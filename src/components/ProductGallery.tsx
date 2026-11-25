"use client";

import Image from "next/image";
import { useState } from "react";

import { useI18n } from "@/i18n/client";
import { fmt } from "@/i18n/format";
import { isSquare, type ImageInfo } from "@/lib/product";

export function ProductGallery({ images, title }: { images: ImageInfo[]; title: string }) {
  const { t } = useI18n();
  const [active, setActive] = useState(0);
  const current = images[active];

  return (
    <div className="gallery">
      <div className="gallery__main">
        {current ? (
          <Image key={current.url} src={current.url} alt={current.alt || title} fill priority sizes="(min-width: 900px) 50vw, 100vw" className={`gallery__img${isSquare(current) ? "" : " gallery__img--fit"}`} />
        ) : (
          <div className="gallery__empty">{t.product.noPhoto}</div>
        )}
      </div>
      {images.length > 1 && (
        <ul className="gallery__thumbs" role="list" aria-label={t.product.photos}>
          {images.map((img, i) => (
            <li key={img.url}>
              <button
                type="button"
                className="gallery__thumb"
                aria-current={i === active}
                aria-label={fmt(t.product.showPhoto, { n: i + 1, total: images.length })}
                onClick={() => setActive(i)}
              >
                <Image src={img.url} alt="" fill sizes="88px" className={isSquare(img) ? undefined : "gallery__img--fit"} />
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
