/**
 * Fills an empty database with placeholder products, categories, photos and homepage settings.
 *   npm run seed              → only runs when there are no products yet
 *   SEED_FRESH=1 npm run seed → deletes existing products, categories and photos first
 * Optional: SEED_ADMIN_EMAIL + SEED_ADMIN_PASSWORD create the first admin account.
 */
import config from "@payload-config";
import { getPayload } from "payload";
import sharp from "sharp";

import { PRODUCTS, ROUTINE, SETS } from "@/data/sample-content";

import { packshotSVG, setSVG, textureSVG, type ArtKind } from "./art";
import { CATEGORY_TEXT, COMMON_TEXT, HOME_TEXT, PRODUCT_TEXT, SET_TEXT, type SeedLocale } from "./translations";

const SEED_LOCALES: SeedLocale[] = ["de", "fr", "it"];

const payload = await getPayload({ config });
const log = (msg: string) => payload.logger.info(`[seed] ${msg}`);

const existing = await payload.count({ collection: "products" });
if (existing.totalDocs > 0 && !process.env.SEED_FRESH) {
  log(`Skipped: ${existing.totalDocs} products already exist. Run with SEED_FRESH=1 to replace them.`);
  process.exit(0);
}

if (process.env.SEED_FRESH) {
  log("Removing existing products, variants, categories and photos…");
  for (const collection of ["products", "variants", "categories", "media"] as const) {
    await payload.delete({ collection, where: { id: { exists: true } }, overrideAccess: true, trash: false } as never);
  }
}

if (process.env.SEED_ADMIN_EMAIL && process.env.SEED_ADMIN_PASSWORD) {
  const admins = await payload.count({ collection: "users", where: { email: { equals: process.env.SEED_ADMIN_EMAIL } } });
  if (!admins.totalDocs) {
    await payload.create({
      collection: "users",
      data: { email: process.env.SEED_ADMIN_EMAIL, password: process.env.SEED_ADMIN_PASSWORD, name: "Store admin", roles: ["admin"] },
      overrideAccess: true,
    });
    log(`Created admin ${process.env.SEED_ADMIN_EMAIL}`);
  }
}

async function upload(svg: string, name: string, alt: string) {
  const data = await sharp(Buffer.from(svg)).png({ compressionLevel: 9 }).toBuffer();
  const doc = await payload.create({
    collection: "media",
    data: { alt },
    file: { data, mimetype: "image/png", name: `${name}.png`, size: data.length },
    overrideAccess: true,
  });
  return doc.id;
}

// Swiss-style prices in Rappen, rounded to .90
const chf = (usd: number) => Math.round(usd * 1.12) * 100 - 10;

const CATEGORIES: Record<string, string> = {
  cleansers: "Cleansers",
  toners: "Toners & essences",
  serums: "Serums & ampoules",
  moisturisers: "Moisturisers",
  suncare: "Sun care",
  treatments: "Masks & treatments",
  sets: "Routine sets",
};
const categoryIds: Record<string, number> = {};
for (const [slug, title] of Object.entries(CATEGORIES)) {
  const doc = await payload.create({ collection: "categories", data: { title, slug }, locale: "en", overrideAccess: true });
  categoryIds[slug] = doc.id;
  for (const locale of SEED_LOCALES) {
    await payload.update({ collection: "categories", id: doc.id, data: { title: CATEGORY_TEXT[locale][slug] }, locale, overrideAccess: true });
  }
}
log(`Created ${Object.keys(categoryIds).length} categories`);

const CATEGORY_OF: Record<string, string> = {
  "p-hydra": "toners",
  "p-barrier": "moisturisers",
  "p-soothe": "serums",
  "p-bright": "toners",
  "p-pore": "treatments",
  "p-blem": "treatments",
  "p-exfo": "cleansers",
  "p-firm": "serums",
  "p-line": "moisturisers",
  "p-sun": "suncare",
  "p-eye": "treatments",
  "p-lip": "treatments",
};
// Varied stock so the storefront shows in-stock, low-stock and sold-out states.
const STOCK: Record<string, number> = { "p-firm": 3, "p-line": 4, "p-eye": 0 };

const BADGE: Record<string, "new" | "bestseller" | "none"> = { Bestseller: "bestseller", New: "new" };

const productIds: Record<string, number> = {};
for (const [i, p] of PRODUCTS.entries()) {
  const slug = p.name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)/g, "");
  const main = await upload(packshotSVG(p.art as ArtKind, p.tint), `${slug}-1`, `${p.name}, ${p.type.toLowerCase()} (placeholder image)`);
  const hover = await upload(textureSVG(p.tint, i + 1), `${slug}-2`, `Texture of ${p.name} (placeholder image)`);
  const price = chf(p.price);
  const doc = await payload.create({
    collection: "products",
    data: {
      title: p.name,
      slug,
      generateSlug: false,
      tagline: p.type,
      size: p.size,
      description: `${p.blurb} Placeholder description: replace with the real product copy in the admin.`,
      howToUse: "After cleansing, apply a small amount to face and neck. Use morning and evening.",
      ingredients: "Placeholder: list the hero ingredients and their concentrations here.",
      gallery: [{ image: main }, { image: hover }],
      priceInCHFEnabled: true,
      priceInCHF: price,
      compareAtPriceInCHF: p.badge === "Sale" ? price + 500 : undefined,
      inventory: STOCK[p.id] ?? 40,
      badge: BADGE[p.badge ?? ""] ?? "none",
      categories: [categoryIds[CATEGORY_OF[p.id] ?? "treatments"]],
      _status: "published",
    },
    locale: "en",
    overrideAccess: true,
  });
  productIds[p.id] = doc.id;
  for (const locale of SEED_LOCALES) {
    const text = PRODUCT_TEXT[locale][p.id];
    const common = COMMON_TEXT[locale];
    await payload.update({
      collection: "products",
      id: doc.id,
      data: {
        title: p.name,
        tagline: text.tagline,
        description: `${text.blurb} ${common.placeholder}`,
        howToUse: common.howToUse,
        ingredients: common.ingredients,
        _status: "published",
      },
      locale,
      overrideAccess: true,
    });
  }
  log(`Product: ${p.name}`);
}

// Related products: same category first.
for (const p of PRODUCTS) {
  const related = PRODUCTS.filter((o) => o.id !== p.id && CATEGORY_OF[o.id] === CATEGORY_OF[p.id]).slice(0, 2);
  const fill = PRODUCTS.filter((o) => o.id !== p.id && !related.includes(o)).slice(0, 4 - related.length);
  await payload.update({
    collection: "products",
    id: productIds[p.id],
    data: { relatedProducts: [...related, ...fill].map((o) => productIds[o.id]) },
    overrideAccess: true,
  });
}

const setIds: number[] = [];
for (const s of SETS) {
  const items = s.items.map((id) => PRODUCTS.find((p) => p.id === id)!);
  const full = items.reduce((sum, p) => sum + chf(p.price), 0);
  const image = await upload(setSVG(items.map((p) => ({ kind: p.art as ArtKind, tint: p.tint }))), s.id, `${s.name} set (placeholder image)`);
  const doc = await payload.create({
    collection: "products",
    data: {
      title: s.name,
      slug: s.name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)/g, ""),
      generateSlug: false,
      tagline: s.note,
      size: "Set of 3",
      description: `${items.map((p) => p.name).join(", ")}, boxed together. Placeholder description.`,
      gallery: [{ image }],
      priceInCHFEnabled: true,
      priceInCHF: Math.round((full * 0.85) / 100) * 100 - 10,
      compareAtPriceInCHF: full,
      inventory: 15,
      categories: [categoryIds.sets],
      relatedProducts: s.items.map((id) => productIds[id]),
      _status: "published",
    },
    locale: "en",
    overrideAccess: true,
  });
  setIds.push(doc.id);
  for (const locale of SEED_LOCALES) {
    await payload.update({
      collection: "products",
      id: doc.id,
      data: {
        title: s.name,
        tagline: SET_TEXT[locale][s.id],
        description: `${items.map((p) => p.name).join(", ")} ${COMMON_TEXT[locale].boxed}`,
        _status: "published",
      },
      locale,
      overrideAccess: true,
    });
  }
  log(`Set: ${s.name}`);
}

await payload.updateGlobal({
  slug: "home",
  data: {
    announcements: [
      { text: "Free shipping in Switzerland & Liechtenstein" },
      { text: "Pay with TWINT, card, Apple Pay or Google Pay" },
      { text: "Free sample with your first order" },
    ],
    hero: {
      title: "Skincare that fits every skin.",
      lede: "Korean-formulated routines, made simple and gentle on every skin.",
    },
    bestsellers: ["p-hydra", "p-soothe", "p-sun", "p-barrier", "p-bright", "p-firm"].map((id) => productIds[id]),
    routine: ROUTINE.map((r) => ({ title: r.title, korean: r.ko, note: r.note, product: productIds[r.productId] })),
    sets: setIds,
  },
  locale: "en",
  overrideAccess: true,
});
// Translated text goes onto the same rows (matched by id), so the English text and products stay put.
const home = await payload.findGlobal({ slug: "home", locale: "en", depth: 0, overrideAccess: true });
for (const locale of SEED_LOCALES) {
  const text = HOME_TEXT[locale];
  await payload.updateGlobal({
    slug: "home",
    data: {
      announcements: (home.announcements ?? []).map((a, i) => ({ id: a.id, text: text.announcements[i] ?? a.text })),
      hero: text.hero,
      routine: (home.routine ?? []).map((r, i) => ({ ...r, title: text.routine[i]?.title ?? r.title, note: text.routine[i]?.note ?? r.note })),
    },
    locale,
    overrideAccess: true,
  });
}
log("Homepage settings saved");
log("Done. Open /admin to manage the store.");
process.exit(0);
