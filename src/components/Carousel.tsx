"use client";

import { useCallback, useEffect, useRef, useState } from "react";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import type { Product } from "@/payload-types";

import { ArrowLeftIcon, ArrowRightIcon } from "./Icons";
import { ProductCard } from "./ProductCard";

type Props = { id: string; title: string; intro?: string; products: Product[]; children?: React.ReactNode };

/** Scroll-snap carousel. No autoplay; arrows, touch, wheel and keyboard (focus the track, use arrow keys). */
export function Carousel({ id, title, intro, products, children }: Props) {
  const { t } = useI18n();
  const trackRef = useRef<HTMLDivElement>(null);
  const [atStart, setAtStart] = useState(true);
  const [atEnd, setAtEnd] = useState(false);

  const update = useCallback(() => {
    const el = trackRef.current;
    if (!el) return;
    setAtStart(el.scrollLeft <= 2);
    setAtEnd(el.scrollLeft + el.clientWidth >= el.scrollWidth - 2);
  }, []);

  useEffect(() => {
    update();
    const el = trackRef.current;
    if (!el) return;
    const ro = new ResizeObserver(update);
    ro.observe(el);
    return () => ro.disconnect();
  }, [update]);

  const page = (dir: 1 | -1) => {
    const el = trackRef.current;
    if (!el) return;
    const reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
    el.scrollBy({ left: dir * el.clientWidth * 0.85, behavior: reduce ? "auto" : "smooth" });
  };

  return (
    <section className="section" id={id} aria-labelledby={`${id}-title`}>
      <div className="section__head">
        <div>
          <h2 id={`${id}-title`} className="section__title">
            {title}
          </h2>
          {intro && <p className="section__intro">{intro}</p>}
        </div>
        <div className="arrows">
          <button type="button" className="icon-btn icon-btn--ring" onClick={() => page(-1)} disabled={atStart} aria-label={fmt(t.carousel.previous, { title })}>
            <ArrowLeftIcon />
          </button>
          <button type="button" className="icon-btn icon-btn--ring" onClick={() => page(1)} disabled={atEnd} aria-label={fmt(t.carousel.next, { title })}>
            <ArrowRightIcon />
          </button>
        </div>
      </div>
      <div
        className="track"
        ref={trackRef}
        onScroll={update}
        tabIndex={0}
        role="region"
        aria-label={fmt(t.carousel.region, { title })}
      >
        {products.map((p) => (
          <div className="track__item" key={p.id}>
            <ProductCard product={p} />
          </div>
        ))}
        {children}
      </div>
    </section>
  );
}
