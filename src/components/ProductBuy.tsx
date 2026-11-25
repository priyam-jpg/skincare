"use client";

import { useState } from "react";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import { percentOff } from "@/lib/currency";
import { variantDocs } from "@/lib/product";
import type { Product } from "@/payload-types";

import { AddToBag } from "./AddToBag";
import { Price } from "./Price";

export function ProductBuy({ product }: { product: Product }) {
  const { t } = useI18n();
  const variants = product.enableVariants ? variantDocs(product) : [];
  const [variantId, setVariantId] = useState<number | undefined>(
    variants.find((v) => (v.inventory ?? 0) > 0)?.id ?? variants[0]?.id,
  );
  const variant = variants.find((v) => v.id === variantId);

  const price = variant?.priceInCHF ?? product.priceInCHF;
  const compareAt = product.compareAtPriceInCHF;
  const stock = variant ? (variant.inventory ?? 0) : (product.inventory ?? 0);
  const threshold = product.lowStockThreshold ?? 5;
  const labelFor = (v: (typeof variants)[number]) =>
    v.options
      ?.map((o) => (typeof o === "object" ? o.label : null))
      .filter(Boolean)
      .join(" / ") || v.title;

  return (
    <div className="buy">
      <Price className="buy__price" price={price} compareAt={compareAt} off={percentOff(price, compareAt)} />
      <p className="buy__tax">{t.product.vat}</p>

      {variants.length > 0 && (
        <fieldset className="variants">
          <legend>{t.product.size}</legend>
          <div className="variants__list">
            {variants.map((v) => (
              <label key={v.id} className="chip chip--option" data-disabled={(v.inventory ?? 0) <= 0}>
                <input
                  type="radio"
                  name="variant"
                  value={v.id}
                  checked={v.id === variantId}
                  onChange={() => setVariantId(v.id)}
                  disabled={(v.inventory ?? 0) <= 0}
                />
                {labelFor(v)}
                {(v.inventory ?? 0) <= 0 && <span className="sr-only"> {t.product.optionSoldOut}</span>}
              </label>
            ))}
          </div>
        </fieldset>
      )}

      <p className="stock" data-level={stock <= 0 ? "out" : stock <= threshold ? "low" : "in"} aria-live="polite">
        {stock <= 0 ? t.product.stockOut : stock <= threshold ? fmt(t.product.stockLow, { n: stock }) : t.product.stockIn}
      </p>

      <AddToBag
        className="btn btn--primary btn--block btn--lg"
        productId={product.id}
        variantId={variant?.id}
        name={product.title}
        stock={stock}
        openBag
        disabled={variants.length > 0 && !variant}
      />
    </div>
  );
}
