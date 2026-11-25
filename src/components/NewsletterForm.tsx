"use client";

import { useState } from "react";

import { useI18n } from "@/i18n/client";

/** UI only: connect to the client's email marketing tool (e.g. Mailchimp, Brevo) before launch. */
export function NewsletterForm() {
  const { t } = useI18n();
  const [done, setDone] = useState(false);
  return (
    <form
      className="news"
      onSubmit={(e) => {
        e.preventDefault();
        setDone(true);
      }}
    >
      <label htmlFor="news-email">{t.newsletter.label}</label>
      <div className="news__row">
        <input id="news-email" type="email" name="email" autoComplete="email" placeholder={t.newsletter.placeholder} required />
        <button type="submit" className="btn btn--primary">
          {t.newsletter.submit}
        </button>
      </div>
      <p className="news__done" role="status">
        {done ? t.newsletter.done : ""}
      </p>
    </form>
  );
}
