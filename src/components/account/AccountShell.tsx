import Link from "next/link";

import { fmt, formatDate, plural } from "@/i18n/format";
import type { Messages } from "@/i18n/messages";
import { getI18n } from "@/i18n/server";
import { formatCHF } from "@/lib/currency";
import type { Order } from "@/payload-types";

export async function AccountShell({ current, title, children }: { current: string; title: string; children: React.ReactNode }) {
  const { t } = await getI18n();
  const links = [
    { href: "/account", label: t.account.details },
    { href: "/account/addresses", label: t.account.addresses },
    { href: "/orders", label: t.account.orders },
    { href: "/logout", label: t.account.logout },
  ];
  return (
    <div className="page account">
      <nav className="account__nav" aria-label={t.account.nav}>
        <ul role="list">
          {links.map((l) => (
            <li key={l.href}>
              <Link href={l.href} aria-current={l.href === current ? "page" : undefined}>
                {l.label}
              </Link>
            </li>
          ))}
        </ul>
      </nav>
      <div className="account__main">
        <h1 className="page__title">{title}</h1>
        {children}
      </div>
    </div>
  );
}

export function statusLabel(t: Messages, status: string | null | undefined) {
  return (t.orders.status as Record<string, string>)[status ?? ""] ?? status ?? "";
}

export async function OrderRow({ order }: { order: Order }) {
  const { locale, t } = await getI18n();
  const count = (order.items ?? []).reduce((n, i) => n + (i.quantity ?? 0), 0);
  return (
    <Link href={`/orders/${order.id}`} className="order-row">
      <span className="order-row__id">{fmt(t.orders.number, { id: order.id })}</span>
      <span className="muted">{formatDate(locale, order.createdAt)}</span>
      <span className="muted">{plural(locale, count, t.orders.items)}</span>
      <span className="status" data-status={order.status}>
        {statusLabel(t, order.status)}
      </span>
      <span className="price">{formatCHF(order.amount)}</span>
    </Link>
  );
}
