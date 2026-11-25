import type { Metadata } from "next";

import { CheckoutPage } from "@/components/checkout/CheckoutPage";
import { getI18n } from "@/i18n/server";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.checkout.title, robots: { index: false } };
}

export default async function Checkout() {
  const { t } = await getI18n();
  return (
    <div className="page">
      <h1 className="page__title">{t.checkout.title}</h1>
      <CheckoutPage />
    </div>
  );
}
