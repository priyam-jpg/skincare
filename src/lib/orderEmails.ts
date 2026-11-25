import type { CollectionAfterChangeHook } from "payload";

import { BRAND } from "./brand";
import { formatCHF } from "./currency";

const escape = (s: string) => s.replace(/[&<>"']/g, (c) => `&#${c.charCodeAt(0)};`);

/**
 * Sends the shopper a confirmation and the store a notification when an order is created.
 * Without SMTP settings Payload only logs the email, so nothing is sent in development.
 */
export const sendOrderEmails: CollectionAfterChangeHook = async ({ doc, operation, req }) => {
  if (operation !== "create") return doc;

  const site = process.env.NEXT_PUBLIC_SERVER_URL || "";
  let to: string | undefined = doc.customerEmail;
  if (!to && doc.customer) {
    const id = typeof doc.customer === "object" ? doc.customer.id : doc.customer;
    const customer = await req.payload.findByID({ collection: "users", id, depth: 0, req }).catch(() => null);
    to = customer?.email;
  }

  const link = `${site}/orders/${doc.id}${doc.customerEmail ? `?email=${encodeURIComponent(doc.customerEmail)}&accessToken=${doc.accessToken}` : ""}`;
  const total = formatCHF(doc.amount);

  try {
    if (to) {
      await req.payload.sendEmail({
        to,
        subject: `${BRAND}: order #${doc.id} confirmed`,
        html: `<p>Thank you for your order.</p><p>Order <strong>#${doc.id}</strong>, total ${escape(total)}.</p><p><a href="${link}">View your order</a></p>`,
      });
    }
    if (process.env.STORE_NOTIFICATION_EMAIL) {
      await req.payload.sendEmail({
        to: process.env.STORE_NOTIFICATION_EMAIL,
        subject: `New order #${doc.id} (${total})`,
        html: `<p>A new order was paid.</p><p><a href="${site}/admin/collections/orders/${doc.id}">Open it in the admin</a></p>`,
      });
    }
  } catch (err) {
    req.payload.logger.error({ err, msg: "Could not send order emails" });
  }
  return doc;
};
