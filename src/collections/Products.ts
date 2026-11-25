import { amountField } from "@payloadcms/plugin-ecommerce";
import type { CollectionOverride } from "@payloadcms/plugin-ecommerce/types";
import { slugField } from "payload";

import { CHF, currenciesConfig } from "@/lib/currency";

export const BADGES = [
  { label: "None", value: "none" },
  { label: "New launch", value: "new" },
  { label: "Bestseller", value: "bestseller" },
  { label: "Limited edition", value: "limited" },
] as const;

export const ProductsCollection: CollectionOverride = ({ defaultCollection }) => ({
  ...defaultCollection,
  admin: {
    ...defaultCollection?.admin,
    group: "Shop",
    useAsTitle: "title",
    defaultColumns: ["title", "inventory", "priceInCHF", "_status", "updatedAt"],
    description:
      "Add, edit and restock products. Publish a product to put it on the site; drafts stay hidden from shoppers.",
  },
  defaultPopulate: {
    ...defaultCollection?.defaultPopulate,
    title: true,
    slug: true,
    _status: true,
    tagline: true,
    size: true,
    gallery: true,
    badge: true,
    priceInCHF: true,
    compareAtPriceInCHF: true,
    inventory: true,
    enableVariants: true,
    variants: true,
    variantOptions: true,
  },
  fields: [
    { name: "title", type: "text", required: true, localized: true, label: "Product name" },
    {
      type: "tabs",
      tabs: [
        {
          label: "Photos & details",
          fields: [
            {
              type: "row",
              fields: [
                {
                  name: "tagline",
                  type: "text",
                  localized: true,
                  admin: { width: "60%", description: "Short type line under the name, e.g. “Hydrating essence”." },
                },
                { name: "size", type: "text", admin: { width: "40%", description: "e.g. 150 ml" } },
              ],
            },
            {
              name: "gallery",
              type: "array",
              label: "Photos",
              minRows: 1,
              labels: { singular: "Photo", plural: "Photos" },
              admin: {
                description:
                  "The first photo is the main image. The second photo is shown when shoppers hover over the product card. Square photos (1:1) work best.",
                initCollapsed: false,
              },
              fields: [{ name: "image", type: "upload", relationTo: "media", required: true }],
            },
            { name: "description", type: "textarea", localized: true, admin: { rows: 4 } },
            {
              type: "row",
              fields: [
                { name: "howToUse", type: "textarea", localized: true, label: "How to use", admin: { width: "50%", rows: 4 } },
                { name: "ingredients", type: "textarea", localized: true, label: "Key ingredients", admin: { width: "50%", rows: 4 } },
              ],
            },
          ],
        },
        {
          label: "Price & stock",
          description:
            "Stock goes down automatically each time an order is paid. At 0 the product shows as sold out and can't be added to the bag.",
          fields: [
            ...defaultCollection.fields,
            amountField({
              currenciesConfig,
              currency: CHF,
              overrides: {
                name: "compareAtPriceInCHF",
                label: "Compare-at price (CHF)",
                admin: {
                  description:
                    "Optional original price. If it is higher than the price, the product shows a “% OFF” tag and the old price struck through.",
                },
              },
            }),
            {
              name: "lowStockThreshold",
              type: "number",
              defaultValue: 5,
              min: 0,
              admin: { description: "Show “Only N left” on the product page when stock is at or below this number." },
            },
          ],
        },
      ],
    },
    {
      name: "badge",
      type: "select",
      defaultValue: "none",
      options: [...BADGES],
      admin: { position: "sidebar", description: "Tag shown on the product photo." },
    },
    {
      name: "categories",
      type: "relationship",
      relationTo: "categories",
      hasMany: true,
      admin: { position: "sidebar", sortOptions: "title" },
    },
    {
      name: "relatedProducts",
      type: "relationship",
      relationTo: "products",
      hasMany: true,
      admin: { position: "sidebar", description: "Shown as “Pairs well with” on the product page." },
      filterOptions: ({ id }) => (id ? { id: { not_in: [id] } } : { id: { exists: true } }),
    },
    slugField(),
  ],
});
