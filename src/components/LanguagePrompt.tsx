"use client";

import { useEffect, useRef, useTransition } from "react";

import { setLocale } from "@/i18n/actions";
import { useI18n } from "@/i18n/client";
import { LOCALE_NAMES, LOCALES, type Locale } from "@/i18n/config";

/**
 * First-visit language picker. Shown until the shopper picks a language; closing it keeps the
 * language guessed from their browser. Either way the choice is saved and it doesn't show again.
 */
export function LanguagePrompt() {
  const { locale, t } = useI18n();
  const ref = useRef<HTMLDialogElement>(null);
  const [pending, startTransition] = useTransition();

  useEffect(() => {
    const el = ref.current;
    if (el && !el.open) el.showModal();
  }, []);

  const choose = (l: Locale) => startTransition(() => setLocale(l));

  return (
    <dialog
      ref={ref}
      className="langprompt"
      aria-labelledby="langprompt-title"
      aria-describedby="langprompt-note"
      onCancel={(e) => {
        e.preventDefault();
        choose(locale);
      }}
    >
      <div className="langprompt__panel">
        <p className="langprompt__welcome" aria-hidden="true">
          {t.lang.welcome}
        </p>
        <h2 id="langprompt-title" className="langprompt__title">
          {t.lang.title}
        </h2>
        <ul className="langprompt__list" role="list">
          {LOCALES.map((l) => (
            <li key={l}>
              <button
                type="button"
                className="langprompt__option"
                lang={l}
                data-suggested={l === locale}
                disabled={pending}
                onClick={() => choose(l)}
              >
                <span className="langprompt__code" aria-hidden="true">
                  {l.toUpperCase()}
                </span>
                {LOCALE_NAMES[l]}
              </button>
            </li>
          ))}
        </ul>
        <p id="langprompt-note" className="langprompt__note">
          {t.lang.note}
        </p>
      </div>
    </dialog>
  );
}
