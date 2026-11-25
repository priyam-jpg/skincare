"use client";

import { useCart, usePayments } from "@payloadcms/plugin-ecommerce/client/react";
import { PaymentElement, useElements, useStripe } from "@stripe/react-stripe-js";
import { useRouter } from "next/navigation";
import { useState } from "react";

import { useI18n } from "@/i18n/client";

import type { AddressInput } from "./AddressFields";

type Props = { customerEmail: string; address: AddressInput | null; onCancel: () => void };

export function orderUrl(result: unknown, email?: string) {
  if (!result || typeof result !== "object" || !("orderID" in result) || !result.orderID) return null;
  const sp = new URLSearchParams();
  if (email) sp.set("email", email);
  if ("accessToken" in result && typeof result.accessToken === "string") sp.set("accessToken", result.accessToken);
  sp.set("placed", "1");
  return `/orders/${result.orderID}?${sp}`;
}

export function PaymentForm({ customerEmail, address, onCancel }: Props) {
  const { t } = useI18n();
  const stripe = useStripe();
  const elements = useElements();
  const router = useRouter();
  const { clearCart } = useCart();
  const { confirmOrder } = usePayments();
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const onSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!stripe || !elements) return;
    setBusy(true);
    setError(null);

    // TWINT and some wallets leave the site to approve the payment and come back to this URL.
    const returnUrl = `${window.location.origin}/checkout/confirm-order?email=${encodeURIComponent(customerEmail)}`;

    const { error: stripeError, paymentIntent } = await stripe.confirmPayment({
      elements,
      redirect: "if_required",
      confirmParams: {
        return_url: returnUrl,
        payment_method_data: {
          billing_details: {
            email: customerEmail,
            name: [address?.firstName, address?.lastName].filter(Boolean).join(" ") || undefined,
            phone: address?.phone ?? undefined,
            address: {
              line1: address?.addressLine1 ?? undefined,
              line2: address?.addressLine2 ?? undefined,
              city: address?.city ?? undefined,
              postal_code: address?.postalCode ?? undefined,
              country: address?.country ?? undefined,
            },
          },
        },
      },
    });

    if (stripeError) {
      setError(stripeError.message ?? t.checkout.payFailed);
      setBusy(false);
      return;
    }

    if (paymentIntent?.status === "succeeded") {
      try {
        const result = await confirmOrder("stripe", {
          additionalData: { paymentIntentID: paymentIntent.id, customerEmail },
        });
        const url = orderUrl(result, customerEmail);
        await clearCart();
        router.push(url ?? "/orders");
      } catch {
        setError(t.checkout.confirmFailed);
        setBusy(false);
      }
    } else {
      setBusy(false);
    }
  };

  return (
    <form className="pay" onSubmit={onSubmit}>
      <PaymentElement options={{ layout: "tabs" }} />
      {error && (
        <p className="form-error" role="alert">
          {error}
        </p>
      )}
      <div className="pay__actions">
        <button className="btn btn--primary btn--lg" type="submit" disabled={!stripe || busy}>
          {busy ? t.checkout.processing : t.checkout.pay}
        </button>
        <button className="btn btn--ghost" type="button" onClick={onCancel} disabled={busy}>
          {t.checkout.backToAddress}
        </button>
      </div>
    </form>
  );
}
