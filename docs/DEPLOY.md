# Running and deploying the store

Stack: Next.js 16 + Payload CMS 3 (admin at `/admin`) + Postgres, Stripe for payments (TWINT, cards, Apple Pay, Google Pay), Cloudinary for uploaded photos. Prices are in CHF and include Swiss VAT.

## Local development

You need Node 24.22.1 or newer (`node -v`).

You also need PostgreSQL 15–18 installed (on Windows, the EDB installer from postgresql.org; the scripts find it in `C:\Program Files\PostgreSQL\<version>\bin`, or set `PG_BIN`). The installer's own database service is not used.

First time:

```bash
npm install
cp .env.example .env  # choose a password in DATABASE_URL, set PAYLOAD_SECRET
npm run db:init       # creates the project's own Postgres in ./.pgdata on port 5433 and starts it
npm run db:restore    # loads handover/database.sql: the 45 products, categories, homepage
npm run dev           # http://localhost:3000, admin at http://localhost:3000/admin
```

After that, only `npm run db:start` and `npm run dev`. The product photos are in `media/`.

- First visit to `/admin` asks you to create a user. **That first account becomes the store admin.** Every account created later through the shop is a customer.
- `npm run import:products` replaces the catalogue with the client's real range: the 45 products from the posters in `/Products`. It cuts each product photo out of its poster, uploads the photos and full posters, creates the products in all four languages and updates the homepage picks. The data is in `src/seed/real-products.data.ts`. Its prices are placeholders, and it removes all existing products and photos first.
- `npm run seed` fills an empty database with the placeholder products. `SEED_FRESH=1 npm run seed` replaces existing products, categories and photos.
- `npm run db:stop` stops the local database. After a reboot, run `npm run db:start` again before `npm run dev`.
- Changed a collection or field? Run `npm run generate:types`. If you added admin components, also run `npm run generate:importmap`. Before deploying, run `npm run migrate:create -- <name>` and commit the new file in `src/migrations`.

## Sharing a demo link from your computer

`npm run share` puts the local store on a temporary public address (Cloudflare quick tunnel, free, no account).
- It starts the database, opens the link, builds the site for that address and starts it on port 3061.
- It prints the link when ready, after 1–3 minutes.
- The link works while that terminal stays open and the computer is awake. Ctrl+C stops it, and every start gives a new address.
- It needs cloudflared, installed once with `winget install --id Cloudflare.cloudflared -e`.
- It can't run at the same time as `npm run dev`, because both use the `.next` folder. Stop one before starting the other.
- On a store with no accounts, the first person to open `/admin` becomes admin, so create yours before sharing.

## Languages

The storefront is in German, French, Italian and English.

- **Choosing a language:** the choice is stored in a `lang` cookie for one year. Until a shopper chooses, a first-visit prompt opens. It suggests the best match from the browser's language and falls back to English. Closing it keeps the suggestion. The header has a picker for switching later.
- **URLs:** every language uses the same address (no `/de/` prefix), so search engines index the default (English) version. If multilingual SEO matters later, move the routes under `[locale]` and add `hreflang` tags.
- **Interface text:** lives in `src/i18n/messages/{en,de,fr,it}.ts`. `en.ts` defines the keys, and TypeScript fails the build if another language is missing one. German uses Swiss spelling ("ss", no "ß").
- **Content from the admin:** Payload localization is on, with English as the fallback. Translatable fields are marked `localized: true`:
  - product name, tagline, description, how to use and ingredients;
  - category name;
  - homepage announcements, hero and routine steps.

  Server queries pass `locale`. The bag request adds `?locale=`, and the shop provider remounts when the language changes so the bag is fetched again.
- **Admin language:** follows the editor's browser language (EN/DE/FR/IT). The field hints written for this store are still English.
- **Not translated yet:**
  - order and password-reset emails;
  - error messages that come from Payload itself, such as "email already registered";
  - photo descriptions (alt text).

## One-time accounts the client needs

| Service | What for | Notes |
|---|---|---|
| **Render** | Hosting the site + Postgres | Web service "Starter" and Postgres "Basic 256 MB" are enough to start. |
| **Stripe** | Payments | Sign up with the Swiss business details. In *Settings → Payment methods*, turn on **TWINT**, Apple Pay and Google Pay. Prices are charged in CHF. |
| **Cloudinary** | Product photos uploaded in the admin | Free plan is fine to start. Render's disk is wiped on every deploy, so photos must not be stored on the server. |
| **Email (SMTP)** | Order confirmations and password resets | Any SMTP provider (e.g. Postmark, Brevo, Infomaniak, the domain's mail host). Without it, emails are only written to the server log. |

## Deploying to Render

1. Push the project to a GitHub or GitLab repository (the `.env` file and `.pgdata` folder are git-ignored on purpose).
2. In Render: **New → Blueprint**, pick the repository. Render reads `render.yaml` and creates the database and the web service in Frankfurt.
3. Fill in the values Render asks for:
   - `NEXT_PUBLIC_SERVER_URL`: the final address, e.g. `https://www.yourdomain.ch`. Use the `onrender.com` address until the domain is connected, then update it and redeploy.
   - Stripe keys (`sk_live_…`, `pk_live_…`; use the `test` keys first).
   - Cloudinary keys (Dashboard → API keys).
   - SMTP settings and `STORE_NOTIFICATION_EMAIL` (where new-order alerts go).
4. Deploy. The database tables are created automatically on first start.
5. Open `https://<your-site>/admin` and create the admin account immediately (the first account becomes admin).
6. Optional: load the placeholder catalogue to see the shop working. From your computer, with `DATABASE_URL` set to the Render database's **External** URL and the Cloudinary keys set, run `npm run seed`. Otherwise add products directly in the admin.

### Connecting the domain

Render → the web service → **Settings → Custom Domains** → add `www.yourdomain.ch` (and the bare domain). Add the DNS records Render shows at the domain registrar. HTTPS is issued automatically. Then set `NEXT_PUBLIC_SERVER_URL` to the new address and redeploy.

### Stripe webhooks (optional)

Checkout does not depend on webhooks. If you later want Stripe events (refunds, disputes) in the logs, add an endpoint in Stripe pointing to `https://<your-site>/api/payments/stripe/webhooks` and put its signing secret in `STRIPE_WEBHOOKS_SIGNING_SECRET`.

## Testing a payment

With Stripe **test** keys: card `4242 4242 4242 4242`, any future date, any CVC. TWINT shows a test approval page. After paying you land on the order page, stock for the purchased items goes down, and the order appears in the admin under **Orders**.

## Known limits

- **Shipping and VAT:** shipping is free everywhere, and prices are taken as VAT-inclusive. Flat-rate or weight-based shipping needs custom work (the commerce plugin does not calculate shipping).
- **Countries:** checkout ships to Switzerland and Liechtenstein only (`addresses.supportedCountries` in `src/payload.config.ts`).
- **Reviews, ingredients and story:** the homepage reviews, ingredient cards and brand story are still sample text in `src/data/sample-content.ts`. They are not editable in the admin yet.
- **Newsletter:** the newsletter form is UI only; connect it to the client's email marketing tool.
- **Stock holds:** stock is not reserved while someone is paying. Two people buying the last unit at the same moment can both pay, so check orders against stock for very low-stock items.
