import Image from "next/image";
import Link from "next/link";

import { INGREDIENTS, REVIEWS } from "@/data/sample-content";
import { fmt } from "@/i18n/format";
import type { Messages } from "@/i18n/messages";
import { getI18n } from "@/i18n/server";
import { BRAND } from "@/lib/brand";
import { formatCHF } from "@/lib/currency";
import { priceOf, productImages, stockOf } from "@/lib/product";
import type { Product } from "@/payload-types";

import { AddToBag } from "./AddToBag";
import { DropIcon, FlaskIcon, HeartIcon, LeafIcon, PinIcon, ShieldIcon, StarIcon } from "./Icons";
import { NewsletterForm } from "./NewsletterForm";
import { Price } from "./Price";
const TRUST_ICONS = [ShieldIcon, LeafIcon, HeartIcon, DropIcon, FlaskIcon, PinIcon];

export async function TrustStrip() {
  const { t } = await getI18n();
  return (
    <section className="trust" aria-label={t.trust.label}>
      <ul className="trust__list" role="list">
        {t.trust.items.map((label, i) => {
          const Icon = TRUST_ICONS[i % TRUST_ICONS.length];
          return (
            <li key={label}>
              <Icon />
              <span>{label}</span>
            </li>
          );
        })}
      </ul>
    </section>
  );
}

export type RoutineStep = { title: string; korean?: string | null; note?: string | null; product?: Product | null };

export async function Routine({ steps }: { steps: RoutineStep[] }) {
  if (!steps.length) return null;
  const { t } = await getI18n();
  return (
    <section className="section routine" id="routine" aria-labelledby="routine-title">
      <div className="routine__intro">
        <h2 id="routine-title" className="section__title">
          {t.routine.title}
        </h2>
        <p className="section__intro">{t.routine.intro}</p>
      </div>
      <ol className="routine__list" role="list">
        {steps.map((step, i) => {
          const p = step.product;
          const img = p ? productImages(p)[0] : undefined;
          return (
            <li className="step" key={`${step.title}-${i}`}>
              <span className="step__n" aria-hidden="true">
                {i + 1}
              </span>
              <div className="step__text">
                <h3 className="step__title">
                  <span className="sr-only">{fmt(t.routine.step, { n: i + 1 })} </span>
                  {step.title}
                  {step.korean && (
                    <span className="step__ko" lang="ko">
                      {step.korean}
                    </span>
                  )}
                </h3>
                {step.note && <p>{step.note}</p>}
              </div>
              {p && (
                <div className="step__product">
                  <Link href={`/products/${p.slug}`} className="step__art">
                    {img && <Image src={img.url} alt="" fill sizes="52px" />}
                  </Link>
                  <div>
                    <Link href={`/products/${p.slug}`} className="step__pname">
                      {p.title}
                    </Link>
                    <p className="step__pmeta">
                      {p.size} · <span className="price">{formatCHF(priceOf(p).price)}</span>
                    </p>
                  </div>
                  <AddToBag
                    className="icon-btn icon-btn--ring"
                    productId={p.id}
                    name={p.title}
                    stock={stockOf(p)}
                    label={t.routine.add}
                  />
                </div>
              )}
            </li>
          );
        })}
      </ol>
    </section>
  );
}

export async function Sets({ sets }: { sets: Product[] }) {
  if (!sets.length) return null;
  const { t } = await getI18n();
  return (
    <section className="section" id="sets" aria-labelledby="sets-title">
      <div className="section__head">
        <div>
          <h2 id="sets-title" className="section__title">
            {t.sets.title}
          </h2>
          <p className="section__intro">{t.sets.intro}</p>
        </div>
      </div>
      <div className="sets">
        {sets.map((set) => {
          const [img] = productImages(set);
          const { price, compareAt, off } = priceOf(set);
          return (
            <article className="set" key={set.id}>
              <Link href={`/products/${set.slug}`} className="set__art" tabIndex={-1} aria-hidden="true">
                {img && <Image src={img.url} alt="" fill sizes="(min-width: 800px) 25vw, 50vw" />}
              </Link>
              <div className="set__body">
                {off ? <span className="seal seal--inline seal--sale">{fmt(t.sets.save, { n: off })}</span> : null}
                <h3 className="set__name">
                  <Link href={`/products/${set.slug}`}>{set.title}</Link>
                </h3>
                {set.tagline && <p className="set__note">{set.tagline}</p>}
                <div className="pcard__buy">
                  <Price price={price} compareAt={compareAt} />
                  <AddToBag productId={set.id} name={set.title} stock={stockOf(set)} label={t.sets.add} />
                </div>
              </div>
            </article>
          );
        })}
      </div>
    </section>
  );
}

export async function Ingredients() {
  const { t } = await getI18n();
  return (
    <div className="photo-band">
      <Image src="/images/herb-oil.png" alt="" fill sizes="100vw" className="photo-band__img" />
      <div className="photo-band__veil" aria-hidden="true" />
      <section className="section" id="ingredients" aria-labelledby="ing-title">
        <div className="section__head">
          <div>
            <h2 id="ing-title" className="section__title">
              {t.ingredients.title}
            </h2>
            <p className="section__intro">{t.ingredients.intro}</p>
          </div>
        </div>
        <ul className="labels" role="list">
          {INGREDIENTS.map((ing, i) => {
            const text = t.ingredients.items[i] ?? { name: ing.en, note: ing.note };
            return (
              <li className="label" key={ing.en}>
                <span className="label__ko" lang="ko" aria-hidden="true">
                  {ing.ko}
                </span>
                <h3 className="label__en">{text.name}</h3>
                <p>{text.note}</p>
              </li>
            );
          })}
        </ul>
      </section>
    </div>
  );
}

export async function Story() {
  const { t } = await getI18n();
  return (
    <section className="section story" id="about" aria-labelledby="story-title">
      <div className="story__img">
        <Image src="/images/portrait-rose.png" alt={t.story.imageAlt} fill sizes="(min-width: 900px) 540px, 100vw" />
      </div>
      <div className="story__text">
        <h2 id="story-title" className="section__title">
          {t.story.title}
        </h2>
        <p>{t.story.p1}</p>
        <p>{t.story.p2}</p>
        <Link className="btn btn--primary" href="/shop">
          {t.story.cta}
        </Link>
      </div>
    </section>
  );
}

function Stars({ n, label }: { n: number; label: string }) {
  return (
    <span className="stars" role="img" aria-label={fmt(label, { n })}>
      {[1, 2, 3, 4, 5].map((i) => (
        <StarIcon key={i} filled={i <= n} />
      ))}
    </span>
  );
}

function ReviewCard({ index, lead, t }: { index: number; lead?: boolean; t: Messages }) {
  const r = REVIEWS[index];
  const text = t.reviews.items[index] ?? { quote: r.quote, skin: r.skin };
  return (
    <figure className={lead ? "review review--lead" : "review"}>
      <blockquote>&ldquo;{text.quote}&rdquo;</blockquote>
      <figcaption>
        <Stars n={r.stars} label={t.reviews.stars} />
        <span className="review__who">
          {r.name} <span>· {fmt(t.reviews.skin, { skin: text.skin })}</span>
        </span>
      </figcaption>
    </figure>
  );
}

export async function Reviews() {
  const { t } = await getI18n();
  return (
    <section className="section" id="reviews" aria-labelledby="rev-title">
      <div className="section__head">
        <h2 id="rev-title" className="section__title">
          {t.reviews.title}
        </h2>
      </div>
      <div className="reviews">
        <ReviewCard index={0} lead t={t} />
        <div className="reviews__side">
          {REVIEWS.slice(1).map((r, i) => (
            <ReviewCard key={r.name} index={i + 1} t={t} />
          ))}
        </div>
      </div>
    </section>
  );
}

export async function Footer() {
  const { t } = await getI18n();
  const f = t.footer;
  return (
    <footer className="footer" id="footer">
      <div className="footer__news">
        <h2 className="footer__title">{f.newsTitle}</h2>
        <NewsletterForm />
      </div>
      <div className="footer__cols">
        <div>
          <p className="footer__brand">{BRAND}</p>
          <p className="footer__note">{f.note}</p>
        </div>
        <nav aria-label={f.shop}>
          <h3>{f.shop}</h3>
          <ul role="list">
            <li><Link href="/shop">{f.allProducts}</Link></li>
            <li><Link href="/#sets">{f.sets}</Link></li>
          </ul>
        </nav>
        <nav aria-label={f.help}>
          <h3>{f.help}</h3>
          <ul role="list">
            <li><Link href="/orders">{f.orders}</Link></li>
            <li><Link href="/account">{f.account}</Link></li>
            <li><a href="mailto:hello@example.com">{f.contact}</a></li>
          </ul>
        </nav>
        <nav aria-label={f.about}>
          <h3>{f.about}</h3>
          <ul role="list">
            <li><Link href="/#ingredients">{f.ingredients}</Link></li>
            <li><Link href="/#reviews">{f.reviews}</Link></li>
            <li><Link href="/#about">{f.story}</Link></li>
          </ul>
        </nav>
      </div>
      <p className="footer__legal">&copy; {BRAND}. {f.rights}</p>
    </footer>
  );
}
