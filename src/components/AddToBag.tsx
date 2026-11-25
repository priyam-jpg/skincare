"use client";

import { useCart } from "@payloadcms/plugin-ecommerce/client/react";
import { useState } from "react";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import { useBagUI } from "@/providers/BagUI";

import { PlusIcon } from "./Icons";

type Props = {
  productId: number;
  variantId?: number;
  name: string;
  /** Units available for the product (or the selected variant). */
  stock: number;
  className?: string;
  /** Button text; defaults to "Add to bag" in the shopper's language. */
  label?: string;
  openBag?: boolean;
  disabled?: boolean;
};

export function AddToBag({ productId, variantId, name, stock, className, label, openBag, disabled }: Props) {
  const { t } = useI18n();
  const { addItem, cart, isLoading } = useCart();
  const { notify, added, setOpen } = useBagUI();
  const [busy, setBusy] = useState(false);
  const text = label ?? t.product.addToBag;

  const inBag =
    cart?.items?.find((item) => {
      const pid = typeof item.product === "object" ? item.product?.id : item.product;
      const vid = item.variant ? (typeof item.variant === "object" ? item.variant?.id : item.variant) : undefined;
      return pid === productId && vid === variantId;
    })?.quantity ?? 0;

  const soldOut = stock <= 0;
  const maxed = !soldOut && inBag >= stock;

  const onClick = async () => {
    setBusy(true);
    try {
      await addItem({ product: productId, ...(variantId ? { variant: variantId } : {}) });
      added();
      notify(fmt(t.product.added, { name }));
      if (openBag) setOpen(true);
    } catch {
      notify(fmt(t.product.addFailed, { name }));
    } finally {
      setBusy(false);
    }
  };

  return (
    <button
      type="button"
      className={className ?? "btn btn--primary"}
      onClick={onClick}
      disabled={disabled || soldOut || maxed || busy || isLoading}
      aria-label={soldOut ? fmt(t.product.soldOutLabel, { name }) : fmt(t.product.addLabel, { label: text, name })}
    >
      {soldOut ? (
        t.product.soldOut
      ) : maxed ? (
        t.product.allInBag
      ) : (
        <>
          <PlusIcon />
          {busy ? t.product.adding : text}
        </>
      )}
    </button>
  );
}
