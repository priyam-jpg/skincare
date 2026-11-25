"use client";

import { useI18n } from "@/i18n/client";
import type { Address } from "@/payload-types";

export const COUNTRIES = ["CH", "LI"] as const;

export type AddressInput = Pick<
  Address,
  "firstName" | "lastName" | "company" | "addressLine1" | "addressLine2" | "postalCode" | "city" | "country" | "phone"
>;

/** Native inputs so browser autofill and validation work; read back with readAddress(form, prefix). */
export function AddressFields({ prefix = "", initial }: { prefix?: string; initial?: Partial<AddressInput> }) {
  const { t } = useI18n();
  const a = t.address;
  const id = (name: string) => `${prefix}${name}`;
  return (
    <div className="fields">
      <div className="field">
        <label htmlFor={id("firstName")}>{a.firstName}</label>
        <input className="field__input" id={id("firstName")} name={id("firstName")} autoComplete="given-name" required defaultValue={initial?.firstName ?? ""} />
      </div>
      <div className="field">
        <label htmlFor={id("lastName")}>{a.lastName}</label>
        <input className="field__input" id={id("lastName")} name={id("lastName")} autoComplete="family-name" required defaultValue={initial?.lastName ?? ""} />
      </div>
      <div className="field field--wide">
        <label htmlFor={id("addressLine1")}>{a.street}</label>
        <input className="field__input" id={id("addressLine1")} name={id("addressLine1")} autoComplete="address-line1" required defaultValue={initial?.addressLine1 ?? ""} />
      </div>
      <div className="field field--wide">
        <label htmlFor={id("addressLine2")}>
          {a.line2} <span className="field__opt">{t.common.optional}</span>
        </label>
        <input className="field__input" id={id("addressLine2")} name={id("addressLine2")} autoComplete="address-line2" defaultValue={initial?.addressLine2 ?? ""} />
      </div>
      <div className="field field--short">
        <label htmlFor={id("postalCode")}>{a.postcode}</label>
        <input
          className="field__input"
          id={id("postalCode")}
          name={id("postalCode")}
          autoComplete="postal-code"
          inputMode="numeric"
          pattern="[0-9]{4}"
          title={a.postcodeHint}
          required
          defaultValue={initial?.postalCode ?? ""}
        />
      </div>
      <div className="field">
        <label htmlFor={id("city")}>{a.city}</label>
        <input className="field__input" id={id("city")} name={id("city")} autoComplete="address-level2" required defaultValue={initial?.city ?? ""} />
      </div>
      <div className="field">
        <label htmlFor={id("country")}>{a.country}</label>
        <select className="field__input field__select" id={id("country")} name={id("country")} autoComplete="country" required defaultValue={initial?.country ?? "CH"}>
          {COUNTRIES.map((c) => (
            <option key={c} value={c}>
              {a.countries[c]}
            </option>
          ))}
        </select>
      </div>
      <div className="field">
        <label htmlFor={id("phone")}>
          {a.phone} <span className="field__opt">{a.phoneHint}</span>
        </label>
        <input className="field__input" id={id("phone")} name={id("phone")} type="tel" autoComplete="tel" defaultValue={initial?.phone ?? ""} />
      </div>
    </div>
  );
}

export function readAddress(form: HTMLFormElement, prefix = ""): AddressInput {
  const data = new FormData(form);
  const get = (name: string) => String(data.get(`${prefix}${name}`) ?? "").trim() || undefined;
  return {
    firstName: get("firstName"),
    lastName: get("lastName"),
    company: get("company"),
    addressLine1: get("addressLine1"),
    addressLine2: get("addressLine2"),
    postalCode: get("postalCode"),
    city: get("city"),
    country: (get("country") ?? "CH") as AddressInput["country"],
    phone: get("phone"),
  };
}

export function AddressText({ address }: { address: Partial<Record<keyof AddressInput, string | null>> }) {
  const { t } = useI18n();
  const countries = t.address.countries as Record<string, string>;
  return (
    <address className="address">
      <strong>
        {address.firstName} {address.lastName}
      </strong>
      <br />
      {address.addressLine1}
      {address.addressLine2 ? `, ${address.addressLine2}` : ""}
      <br />
      {address.postalCode} {address.city}, {countries[address.country ?? ""] ?? address.country}
      {address.phone ? (
        <>
          <br />
          {address.phone}
        </>
      ) : null}
    </address>
  );
}
