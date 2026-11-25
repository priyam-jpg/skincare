import type { Metadata } from "next";
import Link from "next/link";
import { redirect } from "next/navigation";

import { AccountShell, OrderRow } from "@/components/account/AccountShell";
import { AccountDetailsForm } from "@/components/auth/AccountForms";
import { fmt } from "@/i18n/format";
import { getI18n } from "@/i18n/server";
import { getCurrentUser, getPayloadClient } from "@/lib/payload";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.account.title, robots: { index: false } };
}

export default async function AccountPage() {
  const user = await getCurrentUser();
  if (!user) redirect("/login?redirect=/account");

  const { t } = await getI18n();
  const payload = await getPayloadClient();
  const orders = await payload.find({
    collection: "orders",
    where: { customer: { equals: user.id } },
    sort: "-createdAt",
    limit: 3,
    depth: 0,
    user,
    overrideAccess: false,
  });

  return (
    <AccountShell current="/account" title={user.name ? fmt(t.account.helloName, { name: user.name }) : t.account.hello}>
      <section className="panel" aria-labelledby="recent-title">
        <div className="panel__row">
          <h2 id="recent-title" className="panel__title">
            {t.account.recent}
          </h2>
          <Link className="text-link" href="/orders">
            {t.account.viewAll}
          </Link>
        </div>
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
            {t.account.noOrders}{" "}
            <Link className="text-link" href="/shop">
              {t.account.firstFormula}
            </Link>
          </p>
        )}
      </section>
      <section className="panel" aria-labelledby="details-title">
        <h2 id="details-title" className="panel__title">
          {t.account.details}
        </h2>
        <AccountDetailsForm />
      </section>
    </AccountShell>
  );
}
