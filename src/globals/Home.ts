import type { GlobalConfig } from "payload";

import { isAdmin } from "@/access";

export const Home: GlobalConfig = {
  slug: "home",
  label: "Homepage",
  admin: {
    group: "Site",
    description: "Choose what the homepage shows. Products must be published to appear.",
  },
  access: { read: () => true, update: isAdmin },
  fields: [
    {
      name: "announcements",
      type: "array",
      label: "Announcement bar messages",
      maxRows: 3,
      fields: [{ name: "text", type: "text", required: true, localized: true }],
    },
    {
      type: "group",
      name: "hero",
      fields: [
        { name: "title", type: "text", localized: true, defaultValue: "Skincare that fits every skin." },
        { name: "lede", type: "textarea", localized: true, defaultValue: "Korean-formulated routines, made simple and gentle on every skin." },
      ],
    },
    {
      name: "bestsellers",
      type: "relationship",
      relationTo: "products",
      hasMany: true,
      label: "“Most-loved formulas” carousel",
      admin: { description: "Leave empty to show products tagged Bestseller." },
    },
    {
      name: "routine",
      type: "array",
      label: "Five-step routine",
      maxRows: 6,
      fields: [
        {
          type: "row",
          fields: [
            { name: "title", type: "text", required: true, localized: true, admin: { width: "40%" } },
            { name: "korean", type: "text", admin: { width: "20%", description: "Optional Hangul caption" } },
            { name: "product", type: "relationship", relationTo: "products", admin: { width: "40%" } },
          ],
        },
        { name: "note", type: "text", localized: true },
      ],
    },
    {
      name: "sets",
      type: "relationship",
      relationTo: "products",
      hasMany: true,
      label: "“Routines, boxed together” sets",
      admin: { description: "Sets are ordinary products (with their own stock). Pick up to two." },
      maxRows: 2,
    },
  ],
};
