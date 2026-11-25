import type { CollectionConfig } from "payload";
import path from "path";
import { fileURLToPath } from "url";

import { isAdmin } from "@/access";

const dirname = path.dirname(fileURLToPath(import.meta.url));

export const Media: CollectionConfig = {
  slug: "media",
  labels: { singular: "Photo", plural: "Photos" },
  admin: { group: "Shop" },
  access: {
    create: isAdmin,
    delete: isAdmin,
    read: () => true,
    update: isAdmin,
  },
  fields: [
    {
      name: "alt",
      type: "text",
      required: true,
      admin: { description: "Describe the photo for people using screen readers, e.g. “Pink serum bottle with dropper”." },
    },
  ],
  upload: {
    // Used only when Cloudinary is not configured (local development). On Render, set the Cloudinary variables.
    staticDir: path.resolve(dirname, "../../media"),
    mimeTypes: ["image/*"],
    focalPoint: true,
  },
};
