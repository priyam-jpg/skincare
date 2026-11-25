import type { Metadata } from "next";
import { Suspense } from "react";

import { ResetPasswordForm } from "@/components/auth/AuthForms";
import { getI18n } from "@/i18n/server";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.auth.resetTitle, robots: { index: false } };
}

export default async function Page() {
  const { t } = await getI18n();
  return (
    <div className="page page--narrow">
      <h1 className="page__title">{t.auth.resetTitle}</h1>
      <p className="section__intro">{t.auth.resetIntro}</p>
      <Suspense>
        <ResetPasswordForm />
      </Suspense>
    </div>
  );
}
