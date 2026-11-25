"use client";

import { useAddresses, useCart, usePayments } from "@payloadcms/plugin-ecommerce/client/react";
import { Elements } from "@stripe/react-stripe-js";
import { loadStripe } from "@stripe/stripe-js";
import Image from "next/image";
import Link from "next/link";
import { useState } from "react";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import { formatCHF } from "@/lib/currency";
import { productImages } from "@/lib/product";
import type { Product, Variant } from "@/payload-types";
import { useAuth } from "@/providers/Auth";

import { AddressFields, AddressText, readAddress, type AddressInput } from "./AddressFields";
import { PaymentForm } from "./PaymentForm";

const publishableKey = process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY || "";
const stripePromise = publishableKey.startsWith("pk_") && publishableKey.length > 10 ? loadStripe(publishableKey) : null;

const NEW = "new";

export function CheckoutPage() {
  const { locale, t } = useI18n();
  const c = t.checkout;
  const { user } = useAuth();
  const { cart } = useCart();
  const { addresses, createAddress } = useAddresses();
  const { initiatePayment } = usePayments();

  const [email, setEmail] = useState("");
  const [choice, setChoice] = useState<string>("");
  const [address, setAddress] = useState<AddressInput | null>(null);
  const [clientSecret, setClientSecret] = useState<string | null>(null);
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const items = cart?.items ?? [];
  const saved = addresses ?? [];
  const selected = choice || (saved[0] ? String(saved[0].id) : NEW);

  if (!stripePromise) {
    return (
      <div className="notice">
        <h2>{c.notConnectedTitle}</h2>
        <p>{fmt(c.notConnectedText, { public: "NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY", secret: "STRIPE_SECRET_KEY" })}</p>
      </div>
    );
  }

  if (!items.length) {
    return (
      <div className="empty">
        <p>{c.empty}</p>
        <Link className="btn btn--primary" href="/shop">
          {c.continueShopping}
        </Link>
      </div>
    );
  }

  const toPayment = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    setError(null);
    setBusy(true);
    try {
      let shipping: AddressInput;
      if (user && selected !== NEW) {
        const found = saved.find((a) => String(a.id) === selected);
        if (!found) throw new Error(c.chooseAddress);
        shipping = found;
      } else {
        shipping = readAddress(e.currentTarget);
        if (user && new FormData(e.currentTarget).get("saveAddress")) await createAddress(shipping).catch(() => undefined);
      }
      setAddress(shipping);

      const result = (await initiatePayment("stripe", {
        additionalData: {
          ...(user ? {} : { customerEmail: email }),
          billingAddress: shipping,
          shippingAddress: shipping,
        },
      })) as unknown as { clientSecret?: string } | undefined;

      if (!result?.clientSecret) throw new Error(c.startFailed);
      setClientSecret(result.clientSecret);
    } catch (err) {
      const raw = err instanceof Error ? err.message : "";
      setError(/stock|inventory/i.test(raw) ? c.soldOut : raw || c.startFailed);
    } finally {
      setBusy(false);
    }
  };

  const customerEmail = user?.email ?? email;

  return (
    <div className="checkout">
      <div className="checkout__main">
        {!clientSecret ? (
          <form className="checkout__form" onSubmit={toPayment}>
            <section className="panel" aria-labelledby="contact-title">
              <h2 id="contact-title" className="panel__title">
                <span className="panel__n">1</span> {c.contact}
              </h2>
              {user ? (
                <p>
                  {fmt(c.signedInAs, { email: user.email })}{" "}
                  <Link href="/logout" className="text-link">
                    {c.notYou}
                  </Link>
                </p>
              ) : (
                <>
                  <div className="field field--wide">
                    <label htmlFor="email">{c.email}</label>
                    <input className="field__input" id="email" type="email" autoComplete="email" required value={email} onChange={(e) => setEmail(e.target.value)} />
                  </div>
                  <p className="muted">
                    {c.haveAccount}{" "}
                    <Link className="text-link" href="/login?redirect=/checkout">
                      {c.login}
                    </Link>{" "}
                    {c.haveAccountAfter}
                  </p>
                </>
              )}
            </section>

            <section className="panel" aria-labelledby="ship-title">
              <h2 id="ship-title" className="panel__title">
                <span className="panel__n">2</span> {c.shipping}
              </h2>
              {user && saved.length > 0 && (
                <fieldset className="choices">
                  <legend className="sr-only">{c.chooseSaved}</legend>
                  {saved.map((a) => (
                    <label key={a.id} className="choice">
                      <input type="radio" name="addressChoice" value={a.id} checked={selected === String(a.id)} onChange={() => setChoice(String(a.id))} />
                      <AddressText address={a} />
                    </label>
                  ))}
                  <label className="choice">
                    <input type="radio" name="addressChoice" value={NEW} checked={selected === NEW} onChange={() => setChoice(NEW)} />
                    {c.newAddress}
                  </label>
                </fieldset>
              )}
              {(!user || selected === NEW || saved.length === 0) && (
                <>
                  <AddressFields />
                  {user && (
                    <label className="check">
                      <input type="checkbox" name="saveAddress" defaultChecked /> {c.saveAddress}
                    </label>
                  )}
                </>
              )}
            </section>

            {error && (
              <p className="form-error" role="alert">
                {error}
              </p>
            )}
            <button className="btn btn--primary btn--lg" type="submit" disabled={busy}>
              {busy ? c.preparing : c.continue}
            </button>
          </form>
        ) : (
          <section className="panel" aria-labelledby="pay-title">
            <h2 id="pay-title" className="panel__title">
              <span className="panel__n">3</span> {c.payment}
            </h2>
            {address && (
              <div className="panel__summary">
                <span className="muted">{c.shippingTo}</span>
                <AddressText address={address} />
              </div>
            )}
            <Elements
              stripe={stripePromise}
              options={{
                clientSecret,
                locale,
                appearance: {
                  theme: "stripe",
                  variables: {
                    colorPrimary: "#111111",
                    colorText: "#111111",
                    colorDanger: "#b32e5c",
                    borderRadius: "16px",
                    fontFamily: "Google Sans, system-ui, sans-serif",
                    spacingUnit: "4px",
                  },
                },
              }}
            >
              <PaymentForm customerEmail={customerEmail} address={address} onCancel={() => setClientSecret(null)} />
            </Elements>
          </section>
        )}
      </div>

      <aside className="summary" aria-labelledby="summary-title">
        <h2 id="summary-title" className="panel__title">
          {c.summary}
        </h2>
        <ul className="summary__list" role="list">
          {items.map((item, i) => {
            const product = item.product as Product | number;
            if (!product || typeof product !== "object") return null;
            const variant = item.variant && typeof item.variant === "object" ? (item.variant as Variant) : undefined;
            const img = productImages(product)[0];
            const unit = variant?.priceInCHF ?? product.priceInCHF ?? 0;
            return (
              <li key={item.id ?? i} className="summary__item">
                <span className="summary__img">
                  {img && <Image src={img.url} alt="" fill sizes="64px" />}
                  <span className="summary__qty" aria-label={fmt(c.quantity, { n: item.quantity })}>
                    {item.quantity}
                  </span>
                </span>
                <span className="summary__name">
                  {product.title}
                  {variant && <span className="muted"> · {variant.title}</span>}
                </span>
                <span className="price">{formatCHF(unit * (item.quantity ?? 1))}</span>
              </li>
            );
          })}
        </ul>
        <dl className="summary__totals">
          <div>
            <dt>{c.subtotal}</dt>
            <dd className="price">{formatCHF(cart?.subtotal ?? 0)}</dd>
          </div>
          <div>
            <dt>{c.shippingCost}</dt>
            <dd>{c.free}</dd>
          </div>
          <div className="summary__grand">
            <dt>{c.total}</dt>
            <dd className="price">{formatCHF(cart?.subtotal ?? 0)}</dd>
          </div>
        </dl>
        <p className="muted">{c.payNote}</p>
      </aside>
    </div>
  );
}
