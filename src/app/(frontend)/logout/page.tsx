import type { Metadata } from "next";

import { LogoutView } from "@/components/auth/AuthForms";
import { getI18n } from "@/i18n/server";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.auth.logoutTitle, robots: { index: false } };
}

export default function Page() {
  return (
    <div className="page page--narrow">
      <LogoutView />
    </div>
  );
}
