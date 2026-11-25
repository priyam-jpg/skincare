"use client";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import { formatCHF } from "@/lib/currency";

type Props = { price: number | null | undefined; compareAt?: number | null; off?: number | null; className?: string };

export function Price({ price, compareAt, off, className }: Props) {
  const { t } = useI18n();
  if (typeof price !== "number") return null;
  return (
    <span className={`price-group ${className ?? ""}`}>
      <span className="price">{formatCHF(price)}</span>
      {off ? (
        <>
          <s className="price--was">
            <span className="sr-only">{t.product.was} </span>
            {formatCHF(compareAt)}
          </s>
          <span className="price--off">{fmt(t.product.off, { n: off })}</span>
        </>
      ) : null}
    </span>
  );
}
