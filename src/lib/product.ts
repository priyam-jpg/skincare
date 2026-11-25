import type { Media, Product, Variant } from "@/payload-types";

import { percentOff } from "./currency";

export type ImageInfo = { url: string; alt: string; width?: number | null; height?: number | null };

export function mediaInfo(media: number | Media | null | undefined, fallbackAlt = ""): ImageInfo | null {
  if (!media || typeof media !== "object" || !media.url) return null;
  // Local uploads come back as absolute URLs on our own domain; serve them by path so next/image accepts them.
  const url = media.url.replace(/^https?:\/\/[^/]+(?=\/api\/media\/)/, "");
  return { url, alt: media.alt || fallbackAlt, width: media.width, height: media.height };
}

/** Posters and other non-square photos are shown whole (letterboxed) instead of cropped. */
export function isSquare(img: Pick<ImageInfo, "width" | "height">): boolean {
  if (!img.width || !img.height) return true;
  return Math.abs(img.width / img.height - 1) < 0.08;
}

export function productImages(product: Pick<Product, "gallery" | "title">): ImageInfo[] {
  return (product.gallery ?? [])
    .map((item) => mediaInfo(item.image, product.title))
    .filter((x): x is ImageInfo => Boolean(x));
}

export function variantDocs(product: Pick<Product, "variants">): Variant[] {
  return (product.variants?.docs ?? []).filter((v): v is Variant => typeof v === "object" && v !== null);
}

/** Stock across the product, or across its variants when it has them. */
export function stockOf(product: Pick<Product, "enableVariants" | "inventory" | "variants">): number {
  if (product.enableVariants) {
    const variants = variantDocs(product);
    if (variants.length) return variants.reduce((sum, v) => sum + (v.inventory ?? 0), 0);
  }
  return product.inventory ?? 0;
}

export function priceOf(product: Pick<Product, "priceInCHF" | "compareAtPriceInCHF" | "enableVariants" | "variants">) {
  let price = product.priceInCHF ?? null;
  if (product.enableVariants) {
    const prices = variantDocs(product)
      .map((v) => v.priceInCHF)
      .filter((p): p is number => typeof p === "number");
    if (prices.length) price = Math.min(...prices);
  }
  const compareAt = product.compareAtPriceInCHF ?? null;
  return { price, compareAt, off: percentOff(price, compareAt) };
}
