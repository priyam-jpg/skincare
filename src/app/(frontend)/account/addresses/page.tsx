import type { Metadata } from "next";
import { redirect } from "next/navigation";

import { AccountShell } from "@/components/account/AccountShell";
import { AddressBook } from "@/components/auth/AccountForms";
import { getI18n } from "@/i18n/server";
import { getCurrentUser } from "@/lib/payload";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.account.addresses, robots: { index: false } };
}

export default async function AddressesPage() {
  const user = await getCurrentUser();
  if (!user) redirect("/login?redirect=/account/addresses");
  const { t } = await getI18n();
  return (
    <AccountShell current="/account/addresses" title={t.account.addresses}>
      <AddressBook />
    </AccountShell>
  );
}
