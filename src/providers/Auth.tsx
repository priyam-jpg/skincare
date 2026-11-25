"use client";

import { useEcommerce } from "@payloadcms/plugin-ecommerce/client/react";
import { createContext, useCallback, useContext, useEffect, useState } from "react";

import type { User } from "@/payload-types";

type Credentials = { email: string; password: string };

type AuthContext = {
  user: User | null | undefined;
  setUser: (user: User | null) => void;
  login: (args: Credentials) => Promise<User>;
  logout: () => Promise<void>;
  createAccount: (args: Credentials & { name?: string }) => Promise<void>;
  forgotPassword: (email: string) => Promise<void>;
  resetPassword: (args: { token: string; password: string }) => Promise<void>;
};

const Context = createContext<AuthContext | null>(null);

async function api<T>(path: string, init: RequestInit = {}): Promise<T> {
  const res = await fetch(`/api/users${path}`, {
    credentials: "include",
    headers: { "Content-Type": "application/json" },
    ...init,
  });
  const json = await res.json().catch(() => ({}));
  if (!res.ok || json?.errors) {
    throw new Error(json?.errors?.[0]?.message || json?.message || "Something went wrong. Please try again.");
  }
  return json as T;
}

export function AuthProvider({ children }: { children: React.ReactNode }) {
  // undefined = still checking, null = logged out
  const [user, setUser] = useState<User | null | undefined>(undefined);
  const { onLogin, onLogout } = useEcommerce();

  useEffect(() => {
    api<{ user: User | null }>("/me")
      .then(({ user }) => setUser(user ?? null))
      .catch(() => setUser(null));
  }, []);

  const login = useCallback<AuthContext["login"]>(
    async (args) => {
      const { user } = await api<{ user: User }>("/login", { method: "POST", body: JSON.stringify(args) });
      setUser(user);
      await onLogin();
      return user;
    },
    [onLogin],
  );

  const logout = useCallback(async () => {
    await api("/logout", { method: "POST" }).catch(() => undefined);
    setUser(null);
    onLogout();
  }, [onLogout]);

  const createAccount = useCallback<AuthContext["createAccount"]>(
    async ({ email, password, name }) => {
      await api("", { method: "POST", body: JSON.stringify({ email, password, name }) });
      await login({ email, password });
    },
    [login],
  );

  const forgotPassword = useCallback(async (email: string) => {
    await api("/forgot-password", { method: "POST", body: JSON.stringify({ email }) });
  }, []);

  const resetPassword = useCallback<AuthContext["resetPassword"]>(async ({ token, password }) => {
    const { user } = await api<{ user: User }>("/reset-password", {
      method: "POST",
      body: JSON.stringify({ token, password }),
    });
    setUser(user ?? null);
  }, []);

  return (
    <Context.Provider value={{ user, setUser, login, logout, createAccount, forgotPassword, resetPassword }}>
      {children}
    </Context.Provider>
  );
}

export function useAuth() {
  const ctx = useContext(Context);
  if (!ctx) throw new Error("useAuth must be used inside AuthProvider");
  return ctx;
}
