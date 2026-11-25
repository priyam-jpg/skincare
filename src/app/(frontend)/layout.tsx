import type { Metadata, Viewport } from "next";
import { Google_Sans, Noto_Sans_KR } from "next/font/google";

import { AnnouncementBar } from "@/components/AnnouncementBar";
import { CartDrawer } from "@/components/CartDrawer";
import { Header } from "@/components/Header";
import { LanguagePrompt } from "@/components/LanguagePrompt";
import { Footer } from "@/components/Sections";
import type { Locale } from "@/i18n/config";
import { messages } from "@/i18n/messages";
import { getI18n, getLocale } from "@/i18n/server";
import { BRAND } from "@/lib/brand";
import { getPayloadClient } from "@/lib/payload";
import { Providers } from "@/providers/Providers";

import "./globals.css";

const googleSans = Google_Sans({
  variable: "--font-sans",
  subsets: ["latin", "latin-ext"],
  display: "swap",
});

// Hangul captions only; Google Sans has no Korean glyphs.
const notoKR = Noto_Sans_KR({
  variable: "--font-ko",
  weight: ["400", "500"],
  preload: false,
  display: "swap",
});

// The announcement bar and stock are edited live in the admin, so nothing is frozen at build time.
export const dynamic = "force-dynamic";

export async function generateMetadata(): Promise<Metadata> {
  const { t } = await getI18n();
  return {
    metadataBase: new URL(process.env.NEXT_PUBLIC_SERVER_URL || "http://localhost:3000"),
    title: { default: `${BRAND} | ${t.meta.title}`, template: `%s | ${BRAND}` },
    description: t.meta.description,
  };
}

export const viewport: Viewport = {
  width: "device-width",
  initialScale: 1,
  themeColor: "#FFFFFF",
};

async function getAnnouncements(locale: Locale) {
  try {
    const payload = await getPayloadClient();
    const home = await payload.findGlobal({ slug: "home", depth: 0, locale });
    return (home.announcements ?? []).map((a) => a.text).filter((text): text is string => Boolean(text));
  } catch {
    return [];
  }
}

export default async function FrontendLayout({ children }: { children: React.ReactNode }) {
  const { locale, chosen } = await getLocale();
  const t = messages[locale];
  const announcements = await getAnnouncements(locale);
  return (
    <html lang={locale} className={`${googleSans.variable} ${notoKR.variable}`}>
      <body>
        <a className="skip" href="#main">
          {t.common.skip}
        </a>
        <Providers locale={locale} messages={t}>
          <AnnouncementBar messages={announcements} />
          <Header />
          <main id="main">{children}</main>
          <Footer />
          <CartDrawer />
          {!chosen && <LanguagePrompt />}
        </Providers>
      </body>
    </html>
  );
}
