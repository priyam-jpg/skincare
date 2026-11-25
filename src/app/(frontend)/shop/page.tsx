import type { Metadata } from "next";
import Link from "next/link";
import type { Where } from "payload";

import { ProductCard } from "@/components/ProductCard";
import { SortSelect } from "@/components/SortSelect";
import { fmt, plural } from "@/i18n/format";
import { getI18n } from "@/i18n/server";
import { getPayloadClient } from "@/lib/payload";

export const dynamic = "force-dynamic";
export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return { title: t.shop.title, description: t.shop.description };
}

const SORTS: Record<string, string> = {
  featured: "title",
  newest: "-createdAt",
  "price-asc": "priceInCHF",
  "price-desc": "-priceInCHF",
};

type Props = { searchParams: Promise<{ q?: string; category?: string; sort?: string; focus?: string }> };

export default async function ShopPage({ searchParams }: Props) {
  const { q = "", category = "", sort = "featured", focus } = await searchParams;
  const { locale, t } = await getI18n();
  const payload = await getPayloadClient();

  const categories = await payload.find({ collection: "categories", sort: "title", limit: 50, depth: 0, locale });
  const activeCategory = categories.docs.find((c) => c.slug === category);

  const and: Where[] = [{ _status: { equals: "published" } }];
  if (q.trim()) {
    and.push({ or: [{ title: { like: q } }, { tagline: { like: q } }, { description: { like: q } }] });
  }
  if (activeCategory) and.push({ categories: { contains: activeCategory.id } });

  const products = await payload.find({
    collection: "products",
    where: { and },
    sort: SORTS[sort] ?? "title",
    limit: 48,
    depth: 1,
    locale,
  });

  const link = (params: Record<string, string>) => {
    const sp = new URLSearchParams({ ...(q ? { q } : {}), ...(sort !== "featured" ? { sort } : {}), ...params });
    for (const [k, v] of [...sp.entries()]) if (!v) sp.delete(k);
    const s = sp.toString();
    return s ? `/shop?${s}` : "/shop";
  };

  return (
    <div className="page">
      <header className="page__head">
        <h1 className="page__title">{activeCategory ? activeCategory.title : t.shop.title}</h1>
        <p className="section__intro">
          {plural(locale, products.totalDocs, t.shop.count)}
          {q ? ` ${fmt(t.shop.matching, { q })}` : ""}
        </p>
      </header>

      <div className="shop-bar">
        <form className="search" action="/shop" role="search">
          <label className="sr-only" htmlFor="search">
            {t.shop.searchLabel}
          </label>
          <input
            id="search"
            className="field__input"
            type="search"
            name="q"
            defaultValue={q}
            placeholder={t.shop.placeholder}
            autoFocus={focus === "search"}
          />
          {category && <input type="hidden" name="category" value={category} />}
          {sort !== "featured" && <input type="hidden" name="sort" value={sort} />}
          <button className="btn btn--primary" type="submit">
            {t.shop.search}
          </button>
        </form>
        <SortSelect value={sort} />
      </div>

      <nav className="chips" aria-label={t.shop.categories}>
        <Link className="chip" href={link({ category: "" })} aria-current={!activeCategory ? "page" : undefined}>
          {t.shop.all}
        </Link>
        {categories.docs.map((c) => (
          <Link key={c.id} className="chip" href={link({ category: c.slug ?? "" })} aria-current={activeCategory?.id === c.id ? "page" : undefined}>
            {c.title}
          </Link>
        ))}
      </nav>

      {products.docs.length ? (
        <ul className="grid" role="list">
          {products.docs.map((p, i) => (
            <li key={p.id}>
              <ProductCard product={p} priority={i < 4} sizes="(min-width: 1100px) 25vw, (min-width: 700px) 33vw, 50vw" />
            </li>
          ))}
        </ul>
      ) : (
        <div className="empty">
          <p>{t.shop.empty}</p>
          <Link className="btn btn--ghost" href="/shop">
            {t.shop.clear}
          </Link>
        </div>
      )}
    </div>
  );
}
