"use client";

import { useAddresses } from "@payloadcms/plugin-ecommerce/client/react";
import { useState } from "react";

import { AddressFields, AddressText, readAddress } from "@/components/checkout/AddressFields";
import { useI18n } from "@/i18n/client";
import { useAuth } from "@/providers/Auth";
import { useBagUI } from "@/providers/BagUI";

export function AccountDetailsForm() {
  const { t } = useI18n();
  const { user, setUser } = useAuth();
  const { notify } = useBagUI();
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  if (!user) return null;

  const onSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    const data = new FormData(e.currentTarget);
    const body: Record<string, string> = { name: String(data.get("name")), email: String(data.get("email")) };
    const password = String(data.get("password") || "");
    if (password) {
      if (password !== String(data.get("passwordConfirm"))) return setError(t.auth.passwordsDontMatch);
      body.password = password;
    }
    setBusy(true);
    setError(null);
    const res = await fetch(`/api/users/${user.id}`, {
      method: "PATCH",
      credentials: "include",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(body),
    });
    setBusy(false);
    if (!res.ok) return setError(t.account.detailsFailed);
    const json = await res.json();
    setUser(json.doc);
    notify(t.account.detailsSaved);
  };

  return (
    <form className="auth-form" onSubmit={onSubmit} key={user.updatedAt}>
      {error && (
        <p className="form-error" role="alert">
          {error}
        </p>
      )}
      <div className="field">
        <label htmlFor="name">{t.auth.name}</label>
        <input className="field__input" id="name" name="name" autoComplete="name" defaultValue={user.name ?? ""} />
      </div>
      <div className="field">
        <label htmlFor="email">{t.auth.email}</label>
        <input className="field__input" id="email" name="email" type="email" autoComplete="email" required defaultValue={user.email} />
      </div>
      <details className="pw">
        <summary>{t.account.changePassword}</summary>
        <div className="field">
          <label htmlFor="password">{t.auth.newPassword}</label>
          <input className="field__input" id="password" name="password" type="password" autoComplete="new-password" minLength={8} />
        </div>
        <div className="field">
          <label htmlFor="passwordConfirm">{t.auth.confirmNewPassword}</label>
          <input className="field__input" id="passwordConfirm" name="passwordConfirm" type="password" autoComplete="new-password" />
        </div>
      </details>
      <button className="btn btn--primary" type="submit" disabled={busy}>
        {busy ? t.common.saving : t.account.saveChanges}
      </button>
    </form>
  );
}

export function AddressBook() {
  const { t } = useI18n();
  const { addresses, createAddress, updateAddress } = useAddresses();
  const [editing, setEditing] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const save = async (e: React.FormEvent<HTMLFormElement>, id?: number) => {
    e.preventDefault();
    setBusy(true);
    const data = readAddress(e.currentTarget);
    try {
      if (id) await updateAddress(id, data);
      else await createAddress(data);
      setEditing(null);
      setError(null);
    } catch {
      setError(t.account.addressFailed);
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="address-book">
      {error && (
        <p className="form-error" role="alert">
          {error}
        </p>
      )}
      {(addresses ?? []).length === 0 && editing !== "new" && <p className="muted">{t.account.noAddresses}</p>}
      <ul className="address-book__list" role="list">
        {(addresses ?? []).map((a) => (
          <li key={a.id} className="panel">
            {editing === String(a.id) ? (
              <form onSubmit={(e) => save(e, a.id)}>
                <AddressFields initial={a} />
                <div className="notice__actions">
                  <button className="btn btn--primary" disabled={busy}>
                    {t.common.save}
                  </button>
                  <button className="btn btn--ghost" type="button" onClick={() => setEditing(null)}>
                    {t.common.cancel}
                  </button>
                </div>
              </form>
            ) : (
              <div className="address-row">
                <AddressText address={a} />
                <button className="btn btn--ghost" type="button" onClick={() => setEditing(String(a.id))}>
                  {t.common.edit}
                </button>
              </div>
            )}
          </li>
        ))}
      </ul>
      {editing === "new" ? (
        <form className="panel" onSubmit={(e) => save(e)}>
          <h2 className="panel__title">{t.account.newAddress}</h2>
          <AddressFields />
          <div className="notice__actions">
            <button className="btn btn--primary" disabled={busy}>
              {t.account.saveAddress}
            </button>
            <button className="btn btn--ghost" type="button" onClick={() => setEditing(null)}>
              {t.common.cancel}
            </button>
          </div>
        </form>
      ) : (
        <button className="btn btn--ghost" type="button" onClick={() => setEditing("new")}>
          {t.account.addAddress}
        </button>
      )}
    </div>
  );
}
