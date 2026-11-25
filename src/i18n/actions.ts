"use server";

import { cookies } from "next/headers";

import { isLocale, LOCALE_COOKIE } from "./config";

/** Saves the shopper's language. Setting a cookie in a server action re-renders the current page. */
export async function setLocale(locale: string) {
  if (!isLocale(locale)) return;
  (await cookies()).set(LOCALE_COOKIE, locale, { path: "/", maxAge: 60 * 60 * 24 * 365, sameSite: "lax" });
}
