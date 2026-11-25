"use client";

import Image from "next/image";
import Link from "next/link";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import { isSquare, priceOf, productImages, stockOf } from "@/lib/product";
import type { Product } from "@/payload-types";

import { AddToBag } from "./AddToBag";
import { Price } from "./Price";

type Props = { product: Product; sizes?: string; priority?: boolean };

/**
 * The first photo shows by default; on hover (or keyboard focus) the second photo
 * crossfades in and the add button slides up, as on the reference store.
 */
export function ProductCard({ product, sizes = "(min-width: 1100px) 25vw, (min-width: 700px) 33vw, 72vw", priority }: Props) {
  const { t } = useI18n();
  const [main, hover] = productImages(product);
  const { price, compareAt, off } = priceOf(product);
  const stock = stockOf(product);
  const badges = t.product.badges as Record<string, string>;
  const badge = product.badge && product.badge !== "none" ? badges[product.badge] : null;
  const href = `/products/${product.slug}`;

  return (
    <article className="pcard" data-soldout={stock <= 0}>
      <div className="pcard__art">
        <Link href={href} className="pcard__media" tabIndex={-1} aria-hidden="true">
          {main && (
            <Image src={main.url} alt="" fill sizes={sizes} priority={priority} className={`pcard__img${isSquare(main) ? "" : " pcard__img--fit"}`} />
          )}
          {hover && (
            <Image src={hover.url} alt="" fill sizes={sizes} className={`pcard__img pcard__img--hover${isSquare(hover) ? "" : " pcard__img--fit"}`} />
          )}
        </Link>
        <div className="pcard__tags">
          {off ? <span className="seal seal--sale">{fmt(t.product.off, { n: off })}</span> : null}
          {badge ? <span className="seal">{badge}</span> : null}
          {stock <= 0 ? <span className="seal seal--muted">{t.product.soldOut}</span> : null}
        </div>
        {product.enableVariants ? (
          <Link href={href} className="btn btn--primary pcard__quick">
            {t.product.chooseOptions}
          </Link>
        ) : (
          <AddToBag className="btn btn--primary pcard__quick" productId={product.id} name={product.title} stock={stock} />
        )}
      </div>
      <div className="pcard__body">
        <h3 className="pcard__name">
          <Link href={href} className="pcard__link">
            {product.title}
          </Link>
        </h3>
        {(product.tagline || product.size) && (
          <p className="pcard__meta">{[product.tagline, product.size].filter(Boolean).join(" · ")}</p>
        )}
        <div className="pcard__buy">
          <Price price={price} compareAt={compareAt} off={off} />
        </div>
      </div>
    </article>
  );
}
