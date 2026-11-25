import configPromise from "@payload-config";
import { headers } from "next/headers";
import { getPayload } from "payload";

export const getPayloadClient = () => getPayload({ config: configPromise });

/** The logged-in shopper (or admin) for the current request, or null. */
export async function getCurrentUser() {
  const payload = await getPayloadClient();
  const { user } = await payload.auth({ headers: await headers() });
  return user;
}
