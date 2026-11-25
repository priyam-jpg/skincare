"use client";

import { useCart } from "@payloadcms/plugin-ecommerce/client/react";
import Image from "next/image";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useRef } from "react";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import { formatCHF } from "@/lib/currency";
import { productImages } from "@/lib/product";
import type { Product, Variant } from "@/payload-types";
import { useBagUI } from "@/providers/BagUI";

import { BagIcon, CloseIcon, MinusIcon, PlusIcon, TrashIcon } from "./Icons";

export function CartDrawer() {
  const { t } = useI18n();
  const { open, setOpen } = useBagUI();
  const { cart, incrementItem, decrementItem, removeItem, isLoading } = useCart();
  const ref = useRef<HTMLDialogElement>(null);
  const pathname = usePathname();

  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    if (open && !el.open) el.showModal();
    if (!open && el.open) el.close();
  }, [open]);

  useEffect(() => setOpen(false), [pathname, setOpen]);

  const items = cart?.items ?? [];
  const count = items.reduce((n, i) => n + (i.quantity ?? 0), 0);

  return (
    <dialog
      ref={ref}
      className="drawer"
      aria-labelledby="bag-title"
      onClose={() => setOpen(false)}
      onClick={(e) => e.target === e.currentTarget && setOpen(false)}
    >
      <div className="drawer__panel">
        <header className="drawer__head">
          <h2 id="bag-title" className="drawer__title">
            {t.bag.title} {count > 0 && <span className="drawer__count">({count})</span>}
          </h2>
          <button type="button" className="icon-btn" onClick={() => setOpen(false)} aria-label={t.bag.close}>
            <CloseIcon />
          </button>
        </header>

        {items.length === 0 ? (
          <div className="drawer__empty">
            <span className="drawer__empty-icon" aria-hidden="true">
              <BagIcon />
            </span>
            <p>{t.bag.empty}</p>
            <Link className="btn btn--primary" href="/shop">
              {t.bag.start}
            </Link>
          </div>
        ) : (
          <>
            <ul className="bag-list" role="list">
              {items.map((item, i) => {
                const product = item.product as Product | number;
                if (!product || typeof product !== "object") return null;
                const variant = item.variant && typeof item.variant === "object" ? (item.variant as Variant) : undefined;
                const image = productImages(product)[0];
                const unit = variant?.priceInCHF ?? product.priceInCHF ?? 0;
                const stock = variant ? (variant.inventory ?? 0) : (product.inventory ?? 0);
                const qty = item.quantity ?? 1;
                return (
                  <li className="bag-item" key={item.id ?? i}>
                    <Link href={`/products/${product.slug}`} className="bag-item__img">
                      {image && <Image src={image.url} alt="" fill sizes="80px" />}
                    </Link>
                    <div className="bag-item__info">
                      <Link href={`/products/${product.slug}`} className="bag-item__name">
                        {product.title}
                      </Link>
                      <p className="bag-item__meta">
                        {variant
                          ? variant.options
                              ?.map((o) => (typeof o === "object" ? o.label : null))
                              .filter(Boolean)
                              .join(", ")
                          : product.size}
                      </p>
                      <div className="qty" role="group" aria-label={fmt(t.bag.quantityOf, { name: product.title })}>
                        <button
                          type="button"
                          className="qty__btn"
                          onClick={() => item.id && (qty > 1 ? decrementItem(item.id) : removeItem(item.id))}
                          disabled={isLoading}
                          aria-label={qty > 1 ? t.bag.decrease : fmt(t.bag.remove, { name: product.title })}
                        >
                          {qty > 1 ? <MinusIcon /> : <TrashIcon />}
                        </button>
                        <span className="qty__n" aria-live="polite">
                          {qty}
                        </span>
                        <button
                          type="button"
                          className="qty__btn"
                          onClick={() => item.id && incrementItem(item.id)}
                          disabled={isLoading || qty >= stock}
                          aria-label={t.bag.increase}
                        >
                          <PlusIcon />
                        </button>
                      </div>
                    </div>
                    <span className="price bag-item__price">{formatCHF(unit * qty)}</span>
                  </li>
                );
              })}
            </ul>
            <footer className="drawer__foot">
              <div className="drawer__total">
                <span>{t.bag.subtotal}</span>
                <span className="price">{formatCHF(cart?.subtotal ?? 0)}</span>
              </div>
              <p className="drawer__note">{t.bag.note}</p>
              <Link className="btn btn--primary btn--block" href="/checkout">
                {t.bag.checkout}
              </Link>
            </footer>
          </>
        )}
      </div>
    </dialog>
  );
}
