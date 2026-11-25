import type { Metadata } from "next";
import Link from "next/link";
import { notFound } from "next/navigation";
import { cache } from "react";

import { ChevronLeftIcon } from "@/components/Icons";
import { ProductBuy } from "@/components/ProductBuy";
import { ProductCard } from "@/components/ProductCard";
import { ProductGallery } from "@/components/ProductGallery";
import type { Locale } from "@/i18n/config";
import { getI18n } from "@/i18n/server";
import { getPayloadClient } from "@/lib/payload";
import { productImages, priceOf, stockOf } from "@/lib/product";
import type { Product } from "@/payload-types";

export const dynamic = "force-dynamic";

type Props = { params: Promise<{ slug: string }> };

const getProduct = cache(async (slug: string, locale: Locale) => {
  const payload = await getPayloadClient();
  const { docs } = await payload.find({
    collection: "products",
    where: { slug: { equals: slug }, _status: { equals: "published" } },
    limit: 1,
    depth: 2,
    locale,
    populate: { variants: { title: true, priceInCHF: true, inventory: true, options: true } },
  });
  return docs[0] ?? null;
});

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { locale, t } = await getI18n();
  const product = await getProduct((await params).slug, locale);
  if (!product) return { title: t.product.notFound };
  const [img] = productImages(product);
  return {
    title: product.title,
    description: product.description?.slice(0, 160) || product.tagline || undefined,
    openGraph: img ? { images: [{ url: img.url, alt: img.alt }] } : undefined,
  };
}

export default async function ProductPage({ params }: Props) {
  const { locale, t } = await getI18n();
  const product = await getProduct((await params).slug, locale);
  if (!product) notFound();

  const images = productImages(product);
  const { price } = priceOf(product);
  const related = (product.relatedProducts ?? []).filter(
    (p): p is Product => typeof p === "object" && p !== null && p._status === "published",
  );

  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "Product",
    name: product.title,
    description: product.description || product.tagline,
    image: images.map((i) => i.url),
    offers: {
      "@type": "Offer",
      priceCurrency: "CHF",
      price: typeof price === "number" ? (price / 100).toFixed(2) : undefined,
      availability: stockOf(product) > 0 ? "https://schema.org/InStock" : "https://schema.org/OutOfStock",
    },
  };

  return (
    <div className="page">
      <script type="application/ld+json" dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd).replace(/</g, "\\u003c") }} />
      <Link className="back" href="/shop">
        <ChevronLeftIcon />
        {t.product.back}
      </Link>

      <div className="pdp">
        <ProductGallery images={images} title={product.title} />

        <div className="pdp__info">
          <h1 className="pdp__title">{product.title}</h1>
          {(product.tagline || product.size) && (
            <p className="pdp__meta">{[product.tagline, product.size].filter(Boolean).join(" · ")}</p>
          )}
          <ProductBuy product={product} />
          {product.description && <p className="pdp__desc">{product.description}</p>}

          <div className="pdp__details">
            {product.howToUse && (
              <details open>
                <summary>{t.product.howToUse}</summary>
                <p>{product.howToUse}</p>
              </details>
            )}
            {product.ingredients && (
              <details>
                <summary>{t.product.ingredients}</summary>
                <p>{product.ingredients}</p>
              </details>
            )}
            <details>
              <summary>{t.product.shippingTitle}</summary>
              <p>{t.product.shippingText}</p>
            </details>
          </div>
        </div>
      </div>

      {related.length > 0 && (
        <section className="related" aria-labelledby="related-title">
          <h2 id="related-title" className="section__title">
            {t.product.related}
          </h2>
          <ul className="grid" role="list">
            {related.slice(0, 4).map((p) => (
              <li key={p.id}>
                <ProductCard product={p} sizes="(min-width: 1100px) 25vw, 50vw" />
              </li>
            ))}
          </ul>
        </section>
      )}
    </div>
  );
}
