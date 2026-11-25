"use client";

import Link from "next/link";
import { useRouter, useSearchParams } from "next/navigation";
import { getSafeRedirect } from "payload/shared";
import { useEffect, useState } from "react";

import { useI18n } from "@/i18n/client";
import { useAuth } from "@/providers/Auth";

function useRedirect(fallback: string) {
  const params = useSearchParams();
  return getSafeRedirect({ fallbackTo: fallback, redirectTo: params.get("redirect") ?? "" });
}

function useSubmit<T>(action: (data: T) => Promise<void>) {
  const { t } = useI18n();
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);
  const run = async (data: T) => {
    setBusy(true);
    setError(null);
    try {
      await action(data);
    } catch (err) {
      setError(err instanceof Error && err.message ? err.message : t.common.generic);
    } finally {
      setBusy(false);
    }
  };
  return { error, busy, run };
}

const value = (form: HTMLFormElement, name: string) => String(new FormData(form).get(name) ?? "");

function FormError({ error }: { error: string | null }) {
  return error ? (
    <p className="form-error" role="alert">
      {error}
    </p>
  ) : null;
}

export function LoginForm() {
  const { t } = useI18n();
  const a = t.auth;
  const { login } = useAuth();
  const router = useRouter();
  const redirect = useRedirect("/account");
  const params = useSearchParams();
  const { error, busy, run } = useSubmit(async (form: HTMLFormElement) => {
    try {
      await login({ email: value(form, "email"), password: value(form, "password") });
    } catch {
      throw new Error(a.wrongCredentials);
    }
    router.push(redirect);
    router.refresh();
  });
  const qs = params.toString() ? `?${params}` : "";

  return (
    <form className="auth-form" onSubmit={(e) => (e.preventDefault(), run(e.currentTarget))}>
      <FormError error={error} />
      <div className="field">
        <label htmlFor="email">{a.email}</label>
        <input className="field__input" id="email" name="email" type="email" autoComplete="email" required />
      </div>
      <div className="field">
        <label htmlFor="password">{a.password}</label>
        <input className="field__input" id="password" name="password" type="password" autoComplete="current-password" required />
      </div>
      <Link className="text-link" href={`/forgot-password${qs}`}>
        {a.forgot}
      </Link>
      <button className="btn btn--primary btn--block btn--lg" type="submit" disabled={busy}>
        {busy ? a.loggingIn : a.login}
      </button>
      <p className="muted">
        {a.newHere}{" "}
        <Link className="text-link" href={`/create-account${qs}`}>
          {a.createLink}
        </Link>
      </p>
    </form>
  );
}

export function CreateAccountForm() {
  const { t } = useI18n();
  const a = t.auth;
  const { createAccount } = useAuth();
  const router = useRouter();
  const redirect = useRedirect("/account");
  const params = useSearchParams();
  const { error, busy, run } = useSubmit(async (form: HTMLFormElement) => {
    if (value(form, "password") !== value(form, "passwordConfirm")) throw new Error(a.passwordsDontMatch);
    await createAccount({ name: value(form, "name"), email: value(form, "email"), password: value(form, "password") });
    router.push(redirect);
    router.refresh();
  });

  return (
    <form className="auth-form" onSubmit={(e) => (e.preventDefault(), run(e.currentTarget))}>
      <FormError error={error} />
      <div className="field">
        <label htmlFor="name">{a.name}</label>
        <input className="field__input" id="name" name="name" autoComplete="name" required />
      </div>
      <div className="field">
        <label htmlFor="email">{a.email}</label>
        <input className="field__input" id="email" name="email" type="email" autoComplete="email" required />
      </div>
      <div className="field">
        <label htmlFor="password">{a.password}</label>
        <input className="field__input" id="password" name="password" type="password" autoComplete="new-password" minLength={8} required aria-describedby="pw-help" />
        <p id="pw-help" className="field__help">
          {a.passwordHelp}
        </p>
      </div>
      <div className="field">
        <label htmlFor="passwordConfirm">{a.confirmPassword}</label>
        <input className="field__input" id="passwordConfirm" name="passwordConfirm" type="password" autoComplete="new-password" required />
      </div>
      <button className="btn btn--primary btn--block btn--lg" type="submit" disabled={busy}>
        {busy ? a.creating : a.create}
      </button>
      <p className="muted">
        {a.alreadyHave}{" "}
        <Link className="text-link" href={`/login${params.toString() ? `?${params}` : ""}`}>
          {a.login}
        </Link>
      </p>
    </form>
  );
}

export function ForgotPasswordForm() {
  const { t } = useI18n();
  const a = t.auth;
  const { forgotPassword } = useAuth();
  const [sent, setSent] = useState(false);
  const { error, busy, run } = useSubmit(async (form: HTMLFormElement) => {
    await forgotPassword(value(form, "email"));
    setSent(true);
  });

  if (sent) {
    return (
      <p className="notice__text" role="status">
        {a.resetSent}
      </p>
    );
  }
  return (
    <form className="auth-form" onSubmit={(e) => (e.preventDefault(), run(e.currentTarget))}>
      <FormError error={error} />
      <div className="field">
        <label htmlFor="email">{a.email}</label>
        <input className="field__input" id="email" name="email" type="email" autoComplete="email" required />
      </div>
      <button className="btn btn--primary btn--block btn--lg" type="submit" disabled={busy}>
        {busy ? a.sending : a.send}
      </button>
    </form>
  );
}

export function ResetPasswordForm() {
  const { t } = useI18n();
  const a = t.auth;
  const { resetPassword } = useAuth();
  const router = useRouter();
  const token = useSearchParams().get("token") ?? "";
  const { error, busy, run } = useSubmit(async (form: HTMLFormElement) => {
    if (value(form, "password") !== value(form, "passwordConfirm")) throw new Error(a.passwordsDontMatch);
    await resetPassword({ token, password: value(form, "password") });
    router.push("/account");
  });

  if (!token) return <p className="form-error">{a.incompleteLink}</p>;
  return (
    <form className="auth-form" onSubmit={(e) => (e.preventDefault(), run(e.currentTarget))}>
      <FormError error={error} />
      <div className="field">
        <label htmlFor="password">{a.newPassword}</label>
        <input className="field__input" id="password" name="password" type="password" autoComplete="new-password" minLength={8} required />
      </div>
      <div className="field">
        <label htmlFor="passwordConfirm">{a.confirmNewPassword}</label>
        <input className="field__input" id="passwordConfirm" name="passwordConfirm" type="password" autoComplete="new-password" required />
      </div>
      <button className="btn btn--primary btn--block btn--lg" type="submit" disabled={busy}>
        {busy ? t.common.saving : a.setPassword}
      </button>
    </form>
  );
}

export function LogoutView() {
  const { t } = useI18n();
  const a = t.auth;
  const { logout } = useAuth();
  const router = useRouter();
  const [done, setDone] = useState(false);
  useEffect(() => {
    logout().finally(() => {
      setDone(true);
      router.refresh();
    });
  }, [logout, router]);
  return (
    <div className="notice" role="status">
      <h1 className="page__title">{done ? a.loggedOut : a.loggingOut}</h1>
      {done && (
        <div className="notice__actions">
          <Link className="btn btn--primary" href="/shop">
            {a.keepShopping}
          </Link>
          <Link className="btn btn--ghost" href="/login">
            {a.loginAgain}
          </Link>
        </div>
      )}
    </div>
  );
}
