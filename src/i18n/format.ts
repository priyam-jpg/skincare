import { INTL_LOCALE, type Locale } from "./config";

type Vars = Record<string, string | number | null | undefined>;

/** Fills {placeholders}: fmt("Only {n} left", { n: 3 }). */
export function fmt(template: string, vars: Vars = {}): string {
  return template.replace(/\{(\w+)\}/g, (match, key: string) => (vars[key] == null ? match : String(vars[key])));
}

/** Chooses the singular or plural form for n, then fills {n} and any other placeholders. */
export function plural(locale: Locale, n: number, forms: { one: string; other: string }, vars: Vars = {}): string {
  const form = new Intl.PluralRules(INTL_LOCALE[locale]).select(n) === "one" ? forms.one : forms.other;
  return fmt(form, { n, ...vars });
}

export function formatDate(locale: Locale, iso: string): string {
  return new Intl.DateTimeFormat(INTL_LOCALE[locale], { day: "numeric", month: "long", year: "numeric" }).format(new Date(iso));
}
