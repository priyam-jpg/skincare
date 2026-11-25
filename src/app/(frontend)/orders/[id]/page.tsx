import type { Metadata } from "next";
import Image from "next/image";
import Link from "next/link";
import { notFound } from "next/navigation";
import type { Where } from "payload";

import { statusLabel } from "@/components/account/AccountShell";
import { AddressText } from "@/components/checkout/AddressFields";
import { CheckIcon, ChevronLeftIcon } from "@/components/Icons";
import { formatCHF } from "@/lib/currency";
import { fmt, formatDate } from "@/i18n/format";
import { getI18n } from "@/i18n/server";
import { getCurrentUser, getPayloadClient } from "@/lib/payload";
import { productImages } from "@/lib/product";
import type { Order } from "@/payload-types";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.orders.order, robots: { index: false } };
}

type Props = {
  params: Promise<{ id: string }>;
  searchParams: Promise<{ email?: string; accessToken?: string; placed?: string }>;
};

export default async function OrderPage({ params, searchParams }: Props) {
  const { id } = await params;
  const { email = "", accessToken = "", placed } = await searchParams;
  const user = await getCurrentUser();
  const { locale, t } = await getI18n();
  const payload = await getPayloadClient();

  // A customer sees their own orders; a guest needs the private link from their confirmation.
  const owner: Where[] = [];
  if (user) owner.push({ customer: { equals: user.id } });
  if (accessToken) owner.push({ and: [{ accessToken: { equals: accessToken } }, ...(email ? [{ customerEmail: { equals: email } }] : [])] });
  if (!owner.length || !/^\d+$/.test(id)) notFound();

  const { docs } = await payload.find({
    collection: "orders",
    where: { and: [{ id: { equals: Number(id) } }, { or: owner }] },
    depth: 2,
    limit: 1,
    locale,
    overrideAccess: true,
  });
  const order = docs[0] as Order | undefined;
  if (!order) notFound();

  return (
    <div className="page page--narrow">
      {user && (
        <Link className="back" href="/orders">
          <ChevronLeftIcon />
          {t.orders.all}
        </Link>
      )}

      {placed && (
        <div className="success" role="status">
          <span className="success__icon" aria-hidden="true">
            <CheckIcon />
          </span>
          <div>
            <h1 className="page__title">{t.orders.thanks}</h1>
            <p className="muted">
              {fmt(t.orders.confirmation, { email: order.customerEmail || user?.email })}
            </p>
          </div>
        </div>
      )}

      <section className="panel">
        <div className="panel__row">
          <h2 className="panel__title">{fmt(t.orders.number, { id: order.id })}</h2>
          <span className="status" data-status={order.status}>
            {statusLabel(t, order.status)}
          </span>
        </div>
        <p className="muted">{fmt(t.orders.placedOn, { date: formatDate(locale, order.createdAt) })}</p>

        <ul className="summary__list" role="list">
          {(order.items ?? []).map((item, i) => {
            const product = typeof item.product === "object" ? item.product : null;
            const img = product ? productImages(product)[0] : undefined;
            return (
              <li key={item.id ?? i} className="summary__item">
                <span className="summary__img">
                  {img && <Image src={img.url} alt="" fill sizes="64px" />}
                  <span className="summary__qty">{item.quantity}</span>
                </span>
                <span className="summary__name">
                  {product ? <Link href={`/products/${product.slug}`}>{product.title}</Link> : t.orders.unavailable}
                  {item.variant && typeof item.variant === "object" && <span className="muted"> · {item.variant.title}</span>}
                </span>
              </li>
            );
          })}
        </ul>
        <dl className="summary__totals">
          <div className="summary__grand">
            <dt>{t.orders.totalPaid}</dt>
            <dd className="price">{formatCHF(order.amount)}</dd>
          </div>
        </dl>
      </section>

      {order.shippingAddress && (
        <section className="panel">
          <h2 className="panel__title">{t.orders.shippingTo}</h2>
          <AddressText address={order.shippingAddress} />
        </section>
      )}

      {!user && (
        <p className="muted">
          {t.orders.bookmarkBefore}{" "}
          <Link className="text-link" href="/create-account">
            {t.orders.bookmarkLink}
          </Link>{" "}
          {t.orders.bookmarkAfter}
        </p>
      )}
    </div>
  );
}
