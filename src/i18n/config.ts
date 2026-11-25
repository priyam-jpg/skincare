/** Languages offered in the shop, in the order shown in the language picker. */
export const LOCALES = ["de", "fr", "it", "en"] as const;
export type Locale = (typeof LOCALES)[number];

/** Product and page content is written in English first; other languages fall back to it. */
export const DEFAULT_LOCALE: Locale = "en";

/** Remembers the shopper's choice for a year. */
export const LOCALE_COOKIE = "lang";

export const LOCALE_NAMES: Record<Locale, string> = {
  de: "Deutsch",
  fr: "Français",
  it: "Italiano",
  en: "English",
};

/** Swiss regional formats for dates and numbers. */
export const INTL_LOCALE: Record<Locale, string> = {
  de: "de-CH",
  fr: "fr-CH",
  it: "it-CH",
  en: "en-CH",
};

export const isLocale = (value: unknown): value is Locale => LOCALES.includes(value as Locale);

/** Picks the best supported language from an Accept-Language header. */
export function matchLocale(acceptLanguage: string | null | undefined): Locale {
  const wanted = (acceptLanguage ?? "")
    .split(",")
    .map((part) => {
      const [tag, q] = part.trim().split(";q=");
      return { lang: tag.toLowerCase().split("-")[0], q: q ? Number(q) : 1 };
    })
    .filter((x) => x.lang)
    .sort((a, b) => b.q - a.q);
  return wanted.map((x) => x.lang).find(isLocale) ?? DEFAULT_LOCALE;
}
