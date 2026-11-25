"use client";

import { useCart, usePayments } from "@payloadcms/plugin-ecommerce/client/react";
import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { useEffect, useRef, useState } from "react";

import { useI18n } from "@/i18n/client";

import { orderUrl } from "./PaymentForm";

/** Landing page after a redirect payment (TWINT, some wallets): turns the paid intent into an order. */
export function ConfirmOrder() {
  const { t } = useI18n();
  const c = t.checkout;
  const { confirmOrder } = usePayments();
  const { cart, clearCart } = useCart();
  const params = useSearchParams();
  const router = useRouter();
  const started = useRef(false);
  const [error, setError] = useState<string | null>(null);

  const paymentIntentID = params.get("payment_intent");
  const status = params.get("redirect_status");
  const email = params.get("email") ?? undefined;

  useEffect(() => {
    if (started.current || !paymentIntentID || status === "failed" || !cart?.items?.length) return;
    started.current = true;
    confirmOrder("stripe", { additionalData: { paymentIntentID, ...(email ? { customerEmail: email } : {}) } })
      .then(async (result) => {
        const url = orderUrl(result, email);
        await clearCart();
        router.replace(url ?? "/orders");
      })
      .catch(() => setError(c.autoConfirmFailed));
  }, [c.autoConfirmFailed, cart, clearCart, confirmOrder, email, paymentIntentID, router, status]);

  if (!paymentIntentID || status === "failed" || error) {
    return (
      <div className="notice">
        <h1 className="page__title">{c.notCompleted}</h1>
        <p>{error ?? c.cancelled}</p>
        <Link className="btn btn--primary" href="/checkout">
          {c.backToCheckout}
        </Link>
      </div>
    );
  }

  return (
    <div className="notice" role="status">
      <span className="spinner" aria-hidden="true" />
      <h1 className="page__title">{c.confirming}</h1>
      <p>{c.confirmingNote}</p>
    </div>
  );
}
