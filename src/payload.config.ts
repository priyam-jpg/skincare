import { postgresAdapter } from "@payloadcms/db-postgres";
import { nodemailerAdapter } from "@payloadcms/email-nodemailer";
import { cloudStoragePlugin } from "@payloadcms/plugin-cloud-storage";
import { ecommercePlugin } from "@payloadcms/plugin-ecommerce";
import { stripeAdapter } from "@payloadcms/plugin-ecommerce/payments/stripe";
import { lexicalEditor } from "@payloadcms/richtext-lexical";
import { de } from "@payloadcms/translations/languages/de";
import { en } from "@payloadcms/translations/languages/en";
import { fr } from "@payloadcms/translations/languages/fr";
import { it } from "@payloadcms/translations/languages/it";
import path from "path";
import { buildConfig } from "payload";
import sharp from "sharp";
import { fileURLToPath } from "url";

import {
  adminOnlyFieldAccess,
  adminOrPublishedStatus,
  customerOnlyFieldAccess,
  isAdmin,
  isDocumentOwner,
} from "@/access";
import { Categories } from "@/collections/Categories";
import { Media } from "@/collections/Media";
import { ProductsCollection } from "@/collections/Products";
import { Users } from "@/collections/Users";
import { Home } from "@/globals/Home";
import { DEFAULT_LOCALE, LOCALE_NAMES, LOCALES } from "@/i18n/config";
import { BRAND } from "@/lib/brand";
import { cloudinaryAdapter } from "@/lib/cloudinaryAdapter";
import { currenciesConfig } from "@/lib/currency";
import { sendOrderEmails } from "@/lib/orderEmails";
import { migrations } from "@/migrations";

const dirname = path.dirname(fileURLToPath(import.meta.url));
const env = process.env;

const cloudinaryEnabled = Boolean(env.CLOUDINARY_CLOUD_NAME && env.CLOUDINARY_API_KEY && env.CLOUDINARY_API_SECRET);

export default buildConfig({
  serverURL: env.NEXT_PUBLIC_SERVER_URL || "",
  admin: {
    user: Users.slug,
    meta: { titleSuffix: ` · ${BRAND} admin` },
    importMap: { baseDir: path.resolve(dirname) },
  },
  // Admin screens in the editor's own language (picked from their browser, changeable under Account).
  i18n: { supportedLanguages: { en, de, fr, it }, fallbackLanguage: "en" },
  // Product names, descriptions, categories and homepage text can be written once per shop language.
  // Anything left empty shows the English version.
  localization: {
    locales: LOCALES.map((code) => ({ code, label: LOCALE_NAMES[code] })),
    defaultLocale: DEFAULT_LOCALE,
    fallback: true,
  },
  collections: [Users, Categories, Media],
  globals: [Home],
  db: postgresAdapter({
    pool: { connectionString: env.DATABASE_URL || "" },
    // Development syncs the schema automatically; production applies the committed migrations on startup.
    // Set RUN_MIGRATIONS_ON_START=false for a local database that was created by the development sync.
    push: env.NODE_ENV !== "production",
    prodMigrations: env.RUN_MIGRATIONS_ON_START === "false" ? undefined : migrations,
  }),
  editor: lexicalEditor(),
  sharp,
  secret: env.PAYLOAD_SECRET || "",
  typescript: { outputFile: path.resolve(dirname, "payload-types.ts") },
  ...(env.SMTP_HOST
    ? {
        email: nodemailerAdapter({
          defaultFromAddress: env.EMAIL_FROM || "orders@example.com",
          defaultFromName: BRAND,
          transportOptions: {
            host: env.SMTP_HOST,
            port: Number(env.SMTP_PORT || 587),
            auth: { user: env.SMTP_USER, pass: env.SMTP_PASS },
          },
        }),
      }
    : {}),
  plugins: [
    ecommercePlugin({
      access: { adminOnlyFieldAccess, adminOrPublishedStatus, customerOnlyFieldAccess, isAdmin, isDocumentOwner },
      customers: { slug: "users" },
      currencies: currenciesConfig,
      addresses: { supportedCountries: [{ label: "Switzerland", value: "CH" }, { label: "Liechtenstein", value: "LI" }] },
      products: { productsCollectionOverride: ProductsCollection },
      orders: {
        ordersCollectionOverride: ({ defaultCollection }) => ({
          ...defaultCollection,
          admin: { ...defaultCollection.admin, group: "Orders" },
          hooks: {
            ...defaultCollection.hooks,
            afterChange: [...(defaultCollection.hooks?.afterChange ?? []), sendOrderEmails],
          },
          fields: [
            ...defaultCollection.fields,
            {
              // Lets guests open their own order page from the confirmation link without an account.
              name: "accessToken",
              type: "text",
              unique: true,
              index: true,
              admin: { position: "sidebar", readOnly: true },
              hooks: {
                beforeValidate: [({ value, operation }) => (operation === "create" || !value ? crypto.randomUUID() : value)],
              },
            },
          ],
        }),
      },
      payments: {
        paymentMethods: [
          stripeAdapter({
            secretKey: env.STRIPE_SECRET_KEY || "",
            publishableKey: env.NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY || "",
            webhookSecret: env.STRIPE_WEBHOOKS_SIGNING_SECRET || "",
          }),
        ],
      },
    }),
    cloudStoragePlugin({
      enabled: cloudinaryEnabled,
      collections: {
        media: {
          adapter: cloudinaryAdapter({
            cloudName: env.CLOUDINARY_CLOUD_NAME || "",
            apiKey: env.CLOUDINARY_API_KEY || "",
            apiSecret: env.CLOUDINARY_API_SECRET || "",
            folder: env.CLOUDINARY_FOLDER || "store",
          }),
          disablePayloadAccessControl: true,
        },
      },
    }),
  ],
});
