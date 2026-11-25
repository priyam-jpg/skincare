"use client";

import { useTransition } from "react";

import { setLocale } from "@/i18n/actions";
import { useI18n } from "@/i18n/client";
import { LOCALE_NAMES, LOCALES } from "@/i18n/config";

/**
 * A native select (so it works with keyboard, screen readers and phone pickers) laid invisibly
 * over a small "DE ▾" pill. The open list shows each language in its own name.
 */
export function LanguageSelect() {
  const { locale, t } = useI18n();
  const [pending, startTransition] = useTransition();

  return (
    <label className="lang" data-pending={pending}>
      <span className="sr-only">{t.lang.label}</span>
      <span className="lang__code" aria-hidden="true">
        {locale.toUpperCase()}
      </span>
      <svg className="lang__chev" viewBox="0 0 12 12" width="10" height="10" aria-hidden="true">
        <path d="M2.5 4.5 6 8l3.5-3.5" fill="none" stroke="currentColor" strokeWidth="1.6" strokeLinecap="round" strokeLinejoin="round" />
      </svg>
      <select
        className="lang__select"
        value={locale}
        disabled={pending}
        onChange={(e) => {
          const next = e.target.value;
          startTransition(() => setLocale(next));
        }}
      >
        {LOCALES.map((l) => (
          <option key={l} value={l} lang={l}>
            {LOCALE_NAMES[l]}
          </option>
        ))}
      </select>
    </label>
  );
}
