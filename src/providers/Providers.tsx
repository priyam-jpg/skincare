"use client";

import { EcommerceProvider } from "@payloadcms/plugin-ecommerce/client/react";
import { stripeAdapterClient } from "@payloadcms/plugin-ecommerce/payments/stripe";

import { I18nProvider } from "@/i18n/client";
import type { Locale } from "@/i18n/config";
import type { Messages } from "@/i18n/messages";
import { currenciesConfig } from "@/lib/currency";

import { AuthProvider } from "./Auth";
import { BagUIProvider } from "./BagUI";

type Props = { locale: Locale; messages: Messages; children: React.ReactNode };

export function Providers({ locale, messages, children }: Props) {
  return (
    <I18nProvider locale={locale} messages={messages}>
      <EcommerceProvider
        // Remount on a language change so the bag is fetched again with translated product names.
        key={locale}
        enableVariants
        currenciesConfig={currenciesConfig}
        customersSlug="users"
        api={{
          cartsFetchQuery: {
            depth: 2,
            populate: {
              products: { slug: true, title: true, tagline: true, size: true, gallery: true, inventory: true, priceInCHF: true },
              variants: { title: true, inventory: true, priceInCHF: true, options: true },
            },
            // Not in the plugin's type, but it is sent as ?locale= and Payload's REST API honours it.
            ...({ locale } as object),
          },
        }}
        paymentMethods={[stripeAdapterClient({ publishableKey: process.env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY || "" })]}
      >
        <AuthProvider>
          <BagUIProvider>{children}</BagUIProvider>
        </AuthProvider>
      </EcommerceProvider>
    </I18nProvider>
  );
}
