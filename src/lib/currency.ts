import type { Currency } from "@payloadcms/plugin-ecommerce/types";

/** Prices are stored as whole Rappen (1 CHF = 100), as the ecommerce plugin expects. */
export const CHF: Currency = {
  code: "CHF",
  decimals: 2,
  label: "Swiss Franc",
  symbol: "CHF",
};

export const currenciesConfig = {
  supportedCurrencies: [CHF],
  defaultCurrency: "CHF",
};

const formatter = new Intl.NumberFormat("de-CH", { style: "currency", currency: "CHF" });

export function formatCHF(rappen?: number | null): string {
  if (typeof rappen !== "number") return "";
  return formatter.format(rappen / 100);
}

/** Percentage saved against a compare-at price, or null when there is no saving. */
export function percentOff(price?: number | null, compareAt?: number | null): number | null {
  if (!price || !compareAt || compareAt <= price) return null;
  return Math.round(((compareAt - price) / compareAt) * 100);
}
