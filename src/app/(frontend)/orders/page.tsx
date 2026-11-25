import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";

import { AccountShell, OrderRow } from "@/components/account/AccountShell";
import { getI18n } from "@/i18n/server";
import { getCurrentUser, getPayloadClient } from "@/lib/payload";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.orders.title, robots: { index: false } };
}

export default async function OrdersPage() {
  const user = await getCurrentUser();
  if (!user) redirect("/login?redirect=/orders");
  const { t } = await getI18n();
  const payload = await getPayloadClient();
  const orders = await payload.find({
    collection: "orders",
    where: { customer: { equals: user.id } },
    sort: "-createdAt",
    limit: 100,
    depth: 0,
    user,
    overrideAccess: false,
  });

  return (
    <AccountShell current="/orders" title={t.account.orders}>
      {orders.docs.length ? (
        <ul className="orders" role="list">
          {orders.docs.map((o) => (
            <li key={o.id}>
              <OrderRow order={o} />
            </li>
          ))}
        </ul>
      ) : (
        <p className="muted">
          {t.orders.none}{" "}
          <Link className="text-link" href="/shop">
            {t.orders.browse}
          </Link>
        </p>
      )}
    </AccountShell>
  );
}
