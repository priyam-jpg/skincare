"use client";

import { usePathname, useRouter, useSearchParams } from "next/navigation";

import { useI18n } from "@/i18n/client";

const OPTIONS = ["featured", "newest", "price-asc", "price-desc"] as const;

export function SortSelect({ value }: { value: string }) {
  const { t } = useI18n();
  const router = useRouter();
  const pathname = usePathname();
  const params = useSearchParams();

  return (
    <div className="sort">
      <label htmlFor="sort">{t.shop.sortBy}</label>
      <select
        id="sort"
        className="field__input field__select"
        value={value}
        onChange={(e) => {
          const sp = new URLSearchParams(params.toString());
          if (e.target.value === "featured") sp.delete("sort");
          else sp.set("sort", e.target.value);
          sp.delete("focus");
          router.replace(sp.size ? `${pathname}?${sp}` : pathname, { scroll: false });
        }}
      >
        {OPTIONS.map((o) => (
          <option key={o} value={o}>
            {t.shop.sort[o]}
          </option>
        ))}
      </select>
    </div>
  );
}
