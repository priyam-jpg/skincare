import Link from "next/link";

import { getI18n } from "@/i18n/server";

export default async function NotFound() {
  const { t } = await getI18n();
  return (
    <div className="page page--narrow notice">
      <h1 className="page__title">{t.notFound.title}</h1>
      <p className="muted">{t.notFound.text}</p>
      <div className="notice__actions">
        <Link className="btn btn--primary" href="/shop">
          {t.notFound.browse}
        </Link>
        <Link className="btn btn--ghost" href="/">
          {t.notFound.home}
        </Link>
      </div>
    </div>
  );
}
