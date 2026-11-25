import type { CollectionConfig, FieldHook } from "payload";

import { adminOnlyFieldAccess, adminOrSelf, checkRole, isAdmin, publicAccess } from "@/access";

// The very first account created (through /admin on first launch) becomes the store admin.
const ensureFirstUserIsAdmin: FieldHook = async ({ operation, req, value }) => {
  if (operation !== "create") return value;
  const users = await req.payload.find({ collection: "users", depth: 0, limit: 0 });
  if (users.totalDocs === 0 && !(value || []).includes("admin")) return [...(value || []), "admin"];
  return value;
};

export const Users: CollectionConfig = {
  slug: "users",
  labels: { singular: "Customer / admin", plural: "Customers & admins" },
  access: {
    admin: ({ req: { user } }) => checkRole(["admin"], user),
    create: publicAccess,
    delete: isAdmin,
    read: adminOrSelf,
    unlock: isAdmin,
    update: adminOrSelf,
  },
  admin: {
    group: "Customers",
    defaultColumns: ["name", "email", "roles", "createdAt"],
    useAsTitle: "email",
  },
  auth: {
    tokenExpiration: 60 * 60 * 24 * 14,
  },
  fields: [
    { name: "name", type: "text" },
    {
      name: "roles",
      type: "select",
      hasMany: true,
      defaultValue: ["customer"],
      saveToJWT: true,
      access: { create: adminOnlyFieldAccess, read: adminOnlyFieldAccess, update: adminOnlyFieldAccess },
      hooks: { beforeChange: [ensureFirstUserIsAdmin] },
      admin: { description: "Admins can open this dashboard. Customers can only shop and see their own orders." },
      options: [
        { label: "Admin", value: "admin" },
        { label: "Customer", value: "customer" },
      ],
    },
    {
      name: "orders",
      type: "join",
      collection: "orders",
      on: "customer",
      admin: { allowCreate: false, defaultColumns: ["id", "createdAt", "amount", "status"] },
    },
    {
      // Read by the storefront after login to merge a guest bag into the customer's saved bag.
      name: "cart",
      type: "join",
      collection: "carts",
      on: "customer",
      admin: { allowCreate: false },
    },
    {
      name: "addresses",
      type: "join",
      collection: "addresses",
      on: "customer",
      admin: { allowCreate: false },
    },
  ],
};
