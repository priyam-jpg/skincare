import { Carousel } from "@/components/Carousel";
import { Hero } from "@/components/Hero";
import { Ingredients, Reviews, Routine, Sets, Story, TrustStrip, type RoutineStep } from "@/components/Sections";
import { getI18n } from "@/i18n/server";
import { getPayloadClient } from "@/lib/payload";
import type { Product } from "@/payload-types";

// Stock and prices change from the admin at any time, so the homepage is rendered per request.
export const dynamic = "force-dynamic";

const isProduct = (p: unknown): p is Product =>
  typeof p === "object" && p !== null && (p as Product)._status === "published";

export default async function HomePage() {
  const { locale, t } = await getI18n();
  const payload = await getPayloadClient();
  const home = await payload.findGlobal({ slug: "home", depth: 2, locale });

  let bestsellers = (home.bestsellers ?? []).filter(isProduct);
  if (!bestsellers.length) {
    const tagged = await payload.find({
      collection: "products",
      where: { badge: { equals: "bestseller" }, _status: { equals: "published" } },
      limit: 8,
      depth: 1,
      locale,
    });
    bestsellers = tagged.docs;
  }

  const newest = await payload.find({
    collection: "products",
    where: { _status: { equals: "published" } },
    sort: "-createdAt",
    limit: 8,
    depth: 1,
    locale,
  });

  const steps: RoutineStep[] = (home.routine ?? []).map((s) => ({
    title: s.title,
    korean: s.korean,
    note: s.note,
    product: isProduct(s.product) ? s.product : null,
  }));

  return (
    <>
      <Hero title={home.hero?.title} lede={home.hero?.lede} />
      <TrustStrip />
      <Carousel id="bestsellers" title={t.home.bestsellers} intro={t.home.bestsellersIntro} products={bestsellers} />
      <Routine steps={steps} />
      <div className="band">
        <Sets sets={(home.sets ?? []).filter(isProduct)} />
      </div>
      <Ingredients />
      <Carousel id="new" title={t.home.newest} products={newest.docs} />
      <Story />
      <Reviews />
    </>
  );
}
