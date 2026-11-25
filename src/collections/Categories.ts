import { slugField, type CollectionConfig } from "payload";

import { isAdmin } from "@/access";

export const Categories: CollectionConfig = {
  slug: "categories",
  admin: { useAsTitle: "title", group: "Shop", defaultColumns: ["title", "slug"] },
  access: {
    create: isAdmin,
    delete: isAdmin,
    read: () => true,
    update: isAdmin,
  },
  fields: [{ name: "title", type: "text", required: true, localized: true }, slugField({ position: undefined })],
};
