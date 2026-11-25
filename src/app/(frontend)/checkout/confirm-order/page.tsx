import type { Metadata } from "next";
import { Suspense } from "react";

import { ConfirmOrder } from "@/components/checkout/ConfirmOrder";
import { getI18n } from "@/i18n/server";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.checkout.confirmingTitle, robots: { index: false } };
}

export default function ConfirmOrderPage() {
  return (
    <div className="page page--narrow">
      <Suspense>
        <ConfirmOrder />
      </Suspense>
    </div>
  );
}
