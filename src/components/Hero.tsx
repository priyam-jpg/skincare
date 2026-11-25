import Image from "next/image";
import Link from "next/link";
import type { CSSProperties } from "react";

import { getI18n } from "@/i18n/server";

// x, y, size, drift sideways, duration, delay
const BUBBLES = [
  ["6%", "18%", "34px", "14px", "9s", "0s"],
  ["38%", "12%", "64px", "-20px", "13s", "-4s"],
  ["52%", "30%", "22px", "10px", "8s", "-2s"],
  ["70%", "8%", "92px", "-16px", "15s", "-7s"],
  ["88%", "26%", "40px", "18px", "11s", "-3s"],
  ["24%", "78%", "52px", "-12px", "12s", "-6s"],
  ["4%", "62%", "18px", "8px", "7s", "-1s"],
];

export async function Hero({ title, lede }: { title?: string | null; lede?: string | null }) {
  const { t } = await getI18n();
  return (
    <section className="hero" aria-labelledby="hero-title">
      <div className="hero__bubbles" aria-hidden="true">
        {BUBBLES.map(([x, y, s, dx, d, delay]) => (
          <span key={x + y} style={{ "--x": x, "--y": y, "--s": s, "--dx": dx, "--d": d, "--delay": delay } as CSSProperties} />
        ))}
      </div>
      <div className="hero__inner">
        <div className="hero__copy">
          <h1 id="hero-title" className="hero__title">
            {title || t.hero.title}
          </h1>
          <p className="hero__lede">{lede || t.hero.lede}</p>
          <div className="hero__actions">
            <Link className="btn btn--primary" href="/shop">
              {t.hero.shop}
            </Link>
            <a className="btn btn--ghost" href="#routine">
              {t.hero.routine}
            </a>
          </div>
        </div>
      </div>
      <div className="hero__media">
        <Image
          src="/images/hero-flowers.jpg"
          alt={t.hero.imageAlt}
          fill
          priority
          quality={90}
          sizes="(min-width: 700px) 62vw, 100vw"
          className="hero__img"
        />
      </div>
    </section>
  );
}
