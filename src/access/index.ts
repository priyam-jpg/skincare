import type { Access, FieldAccess } from "payload";

type WithRoles = { roles?: (string | null)[] | null } | null | undefined;

export const checkRole = (roles: string[], user: WithRoles): boolean =>
  Boolean(user?.roles?.some((role) => role && roles.includes(role)));

export const publicAccess: Access = () => true;

export const isAdmin: Access = ({ req }) => checkRole(["admin"], req.user as WithRoles);

export const adminOnlyFieldAccess: FieldAccess = ({ req }) => checkRole(["admin"], req.user as WithRoles);

export const customerOnlyFieldAccess: FieldAccess = ({ req }) => checkRole(["customer"], req.user as WithRoles);

/** Shoppers only ever see published products; admins see drafts too. */
export const adminOrPublishedStatus: Access = ({ req }) => {
  if (checkRole(["admin"], req.user as WithRoles)) return true;
  return { _status: { equals: "published" } };
};

/** Customers can read and edit their own account; admins can manage everyone. */
export const adminOrSelf: Access = ({ req }) => {
  if (!req.user) return false;
  if (checkRole(["admin"], req.user as WithRoles)) return true;
  return { id: { equals: req.user.id } };
};

/** Orders, carts and addresses: admins see all, customers see only their own. */
export const isDocumentOwner: Access = ({ req }) => {
  if (checkRole(["admin"], req.user as WithRoles)) return true;
  if (req.user?.id) return { customer: { equals: req.user.id } };
  return false;
};
