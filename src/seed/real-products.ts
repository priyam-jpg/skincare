/**
 * Replaces the placeholder catalogue with the client's real products (posters in /Products).
 *   npm run import:products
 *
 * What it does:
 *  1. Deletes every product, variant and uploaded photo (the old placeholders).
 *  2. Adds the Hair & scalp, Body care and Lip care categories (translated).
 *  3. Cuts the product photos out of the posters, uploads them plus the full posters, and creates each product
 *     in English, then adds the German, French and Italian texts.
 *  4. Points the homepage's bestsellers, routine steps and sets at the new products.
 *
 * Safe to run again: it starts by removing what it created last time.
 */
import config from "@payload-config";
import { getPayload } from "payload";

import { CATEGORY_TEXT } from "./translations";
import {
  CATEGORY_OF_TYPE,
  HOME_BESTSELLERS,
  HOME_ROUTINE,
  HOME_SETS,
  NEW_CATEGORIES,
  PRODUCTS,
  TYPE_TEXT,
  type L,
} from "./real-products.data";
import { posterFiles, posterImage, productShot } from "./real-products.images";

const LOCALES = ["de", "fr", "it"] as const;
const STOCK = 20;

const payload = await getPayload({ config });
const log = (msg: string) => payload.logger.info(`[import] ${msg}`);

const slugify = (s: string) =>
  s
    .normalize("NFKD")
    .replace(/[̀-ͯ]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, "-")
    .replace(/(^-|-$)/g, "");

// 1. Remove the old catalogue.
log("Removing old products, variants and photos…");
for (const collection of ["products", "variants", "media"] as const) {
  await payload.delete({ collection, where: { id: { exists: true } }, overrideAccess: true, trash: false } as never);
}

// 2. Categories: keep the existing skincare ones, add the new ones.
const categoryIds: Record<string, number> = {};
const existing = await payload.find({ collection: "categories", limit: 100, depth: 0, locale: "en" });
for (const c of existing.docs) if (c.slug) categoryIds[c.slug] = c.id;
for (const [slug, title] of Object.entries(NEW_CATEGORIES)) {
  if (categoryIds[slug]) continue;
  const doc = await payload.create({ collection: "categories", data: { title: title.en, slug }, locale: "en", overrideAccess: true });
  for (const locale of LOCALES) {
    await payload.update({ collection: "categories", id: doc.id, data: { title: title[locale] }, locale, overrideAccess: true });
  }
  categoryIds[slug] = doc.id;
  log(`Category: ${title.en}`);
}
// Make sure the original categories have their translations too (they are seeded by the placeholder seed).
for (const [slug, id] of Object.entries(categoryIds)) {
  for (const locale of LOCALES) {
    const t = CATEGORY_TEXT[locale]?.[slug];
    if (t) await payload.update({ collection: "categories", id, data: { title: t }, locale, overrideAccess: true });
  }
}

// 3. Products.
const files = await posterFiles();
if (files.length < 40) throw new Error(`Expected 40 posters in /Products, found ${files.length}`);

async function upload(data: Buffer, name: string, alt: string) {
  const doc = await payload.create({
    collection: "media",
    data: { alt },
    file: { data, mimetype: "image/webp", name: `${name}.webp`, size: data.length },
    overrideAccess: true,
  });
  return doc.id;
}

const productIds: Record<string, number> = {};
const pick = (l: L | undefined, locale: keyof L) => (l ? l[locale] : undefined);

for (const p of PRODUCTS) {
  const slug = slugify(p.title);
  const gallery: { image: number }[] = [];
  for (const [i, shot] of p.shots.entries()) {
    gallery.push({ image: await upload(await productShot(files, shot), `${slug}-${i + 1}`, p.title) });
  }
  for (const [i, poster] of p.posters.entries()) {
    gallery.push({ image: await upload(await posterImage(files, poster), `${slug}-poster-${i + 1}`, `${p.title}, product information`) });
  }

  const typeText = TYPE_TEXT[p.type];
  const howToUse = p.howToUse ?? typeText.howToUse;
  const doc = await payload.create({
    collection: "products",
    data: {
      title: p.title,
      slug,
      generateSlug: false,
      tagline: typeText.tagline.en,
      size: p.size,
      description: p.description.en,
      howToUse: pick(howToUse, "en"),
      ingredients: pick(p.ingredients, "en"),
      gallery,
      priceInCHFEnabled: true,
      priceInCHF: p.price,
      inventory: STOCK,
      badge: p.badge ?? "none",
      categories: [categoryIds[CATEGORY_OF_TYPE[p.type]]].filter(Boolean),
      _status: "published",
    },
    locale: "en",
    overrideAccess: true,
  });
  for (const locale of LOCALES) {
    await payload.update({
      collection: "products",
      id: doc.id,
      data: {
        title: p.title,
        tagline: typeText.tagline[locale],
        description: p.description[locale],
        howToUse: pick(howToUse, locale),
        ingredients: pick(p.ingredients, locale),
        _status: "published",
      },
      locale,
      overrideAccess: true,
    });
  }
  productIds[p.key] = doc.id;
  log(`Product: ${p.title}`);
}

// Related products: others in the same category.
for (const p of PRODUCTS) {
  const cat = CATEGORY_OF_TYPE[p.type];
  const related = PRODUCTS.filter((o) => o.key !== p.key && CATEGORY_OF_TYPE[o.type] === cat).slice(0, 4);
  if (!related.length) continue;
  await payload.update({
    collection: "products",
    id: productIds[p.key],
    data: { relatedProducts: related.map((o) => productIds[o.key]) },
    overrideAccess: true,
  });
}

// 4. Homepage: same texts, new products.
const ids = (keys: string[]) => keys.map((k) => productIds[k]).filter(Boolean);
const home = await payload.findGlobal({ slug: "home", locale: "en", depth: 0, overrideAccess: true });
await payload.updateGlobal({
  slug: "home",
  data: {
    bestsellers: ids(HOME_BESTSELLERS),
    sets: ids(HOME_SETS),
    // Keep each routine row (and its translated title/note) by id; only swap the product shown next to it.
    routine: (home.routine ?? []).map((row, i) => ({ ...row, product: productIds[HOME_ROUTINE[i]] ?? row.product })),
  },
  locale: "en",
  overrideAccess: true,
});
log("Homepage bestsellers, routine and sets updated");
log(`Done: ${PRODUCTS.length} products imported.`);
process.exit(0);
