import { cookies, headers } from "next/headers";
import { cache } from "react";

import { isLocale, LOCALE_COOKIE, matchLocale, type Locale } from "./config";
import { messages, type Messages } from "./messages";

/**
 * The shopper's language: their saved choice, otherwise the best match for their browser.
 * `chosen` is false until they pick one, which is when the language prompt shows.
 */
export const getLocale = cache(async (): Promise<{ locale: Locale; chosen: boolean }> => {
  const saved = (await cookies()).get(LOCALE_COOKIE)?.value;
  if (isLocale(saved)) return { locale: saved, chosen: true };
  return { locale: matchLocale((await headers()).get("accept-language")), chosen: false };
});

export async function getI18n(): Promise<{ locale: Locale; t: Messages }> {
  const { locale } = await getLocale();
  return { locale, t: messages[locale] };
}
