"use client";

import { createContext, useContext } from "react";

import type { Locale } from "./config";
import type { Messages } from "./messages";

type I18n = { locale: Locale; t: Messages };

const Context = createContext<I18n | null>(null);

/** The layout passes in only the current language's text, so the other languages never reach the browser. */
export function I18nProvider({ locale, messages, children }: { locale: Locale; messages: Messages; children: React.ReactNode }) {
  return <Context.Provider value={{ locale, t: messages }}>{children}</Context.Provider>;
}

export function useI18n(): I18n {
  const ctx = useContext(Context);
  if (!ctx) throw new Error("useI18n must be used inside I18nProvider");
  return ctx;
}
