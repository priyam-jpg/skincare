"use client";

import { useCart } from "@payloadcms/plugin-ecommerce/client/react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, useState } from "react";

import { useI18n } from "@/i18n/client";
import { fmt, plural } from "@/i18n/format";
import { BRAND } from "@/lib/brand";
import { useAuth } from "@/providers/Auth";
import { useBagUI } from "@/providers/BagUI";

import { BagIcon, CloseIcon, MenuIcon, SearchIcon, UserIcon } from "./Icons";
import { LanguageSelect } from "./LanguageSelect";

export function Header() {
  const { locale, t } = useI18n();
  const NAV = [
    { label: t.header.shopAll, href: "/shop" },
    { label: t.header.routine, href: "/#routine" },
    { label: t.header.ingredients, href: "/#ingredients" },
    { label: t.header.about, href: "/#about" },
    { label: t.header.myOrders, href: "/orders", mobileOnly: true },
  ];
  const [open, setOpen] = useState(false);
  const [scrolled, setScrolled] = useState(false);
  const pathname = usePathname();
  const overlay = pathname === "/";
  const { cart } = useCart();
  const { user } = useAuth();
  const { setOpen: setBagOpen, bump } = useBagUI();
  const count = cart?.items?.reduce((n, i) => n + (i.quantity ?? 0), 0) ?? 0;

  useEffect(() => {
    const onScroll = () => setScrolled(window.scrollY > 8);
    onScroll();
    window.addEventListener("scroll", onScroll, { passive: true });
    return () => window.removeEventListener("scroll", onScroll);
  }, []);

  // Close the mobile menu whenever the route changes.
  const [lastPath, setLastPath] = useState(pathname);
  if (pathname !== lastPath) {
    setLastPath(pathname);
    setOpen(false);
  }

  useEffect(() => {
    if (!open) return;
    const onKey = (e: KeyboardEvent) => e.key === "Escape" && setOpen(false);
    window.addEventListener("keydown", onKey);
    return () => window.removeEventListener("keydown", onKey);
  }, [open]);

  return (
    <header className="header" data-overlay={overlay} data-solid={!overlay || scrolled || open}>
      <div className="header__inner">
        <button
          type="button"
          className="icon-btn header__menu"
          aria-expanded={open}
          aria-controls="site-nav"
          aria-label={open ? t.header.closeMenu : t.header.openMenu}
          onClick={() => setOpen((o) => !o)}
        >
          {open ? <CloseIcon /> : <MenuIcon />}
        </button>

        <Link className="logo" href="/" aria-label={fmt(t.header.home, { brand: BRAND })}>
          <span className="logo__mark" aria-hidden="true" />
          {BRAND}
        </Link>

        <nav id="site-nav" className="nav" data-open={open} aria-label={t.header.mainMenu}>
          <ul role="list">
            {NAV.map((item) => (
              <li key={item.href} className={item.mobileOnly ? "nav__mobile-only" : undefined}>
                <Link href={item.href} aria-current={pathname === item.href ? "page" : undefined}>
                  {item.label}
                </Link>
              </li>
            ))}
          </ul>
        </nav>

        <div className="header__tools">
          <Link className="header__track" href="/orders">
            {t.header.myOrders}
          </Link>
          <LanguageSelect />
          <Link className="icon-btn" href="/shop?focus=search" aria-label={t.header.search}>
            <SearchIcon />
          </Link>
          <Link className="icon-btn header__account" href={user ? "/account" : "/login"} aria-label={user ? t.header.account : t.header.login}>
            <UserIcon />
          </Link>
          <button
            type="button"
            className="icon-btn bag"
            onClick={() => setBagOpen(true)}
            aria-label={plural(locale, count, t.header.bag)}
          >
            <span className="bag__icon" data-bump={bump > 0} key={`bag-${bump}`}>
              <BagIcon />
            </span>
            {count > 0 && (
              <span className="bag__count" aria-hidden="true" key={count}>
                {count}
              </span>
            )}
          </button>
        </div>
      </div>
    </header>
  );
}
