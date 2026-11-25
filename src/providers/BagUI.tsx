"use client";

import { createContext, useCallback, useContext, useState } from "react";

type BagUI = {
  open: boolean;
  setOpen: (open: boolean) => void;
  /** Announces a short message to screen readers and shows it as a toast. */
  notify: (message: string) => void;
  /** Increments every time something is added, so the bag icon can wiggle. */
  bump: number;
  added: () => void;
};

const Context = createContext<BagUI | null>(null);

export function BagUIProvider({ children }: { children: React.ReactNode }) {
  const [open, setOpen] = useState(false);
  const [message, setMessage] = useState("");
  const [bump, setBump] = useState(0);

  const notify = useCallback((text: string) => {
    setMessage("");
    requestAnimationFrame(() => setMessage(text));
    window.setTimeout(() => setMessage((m) => (m === text ? "" : m)), 3500);
  }, []);

  const added = useCallback(() => setBump((n) => n + 1), []);

  return (
    <Context.Provider value={{ open, setOpen, notify, bump, added }}>
      {children}
      <div className="toast" role="status" aria-live="polite" data-show={Boolean(message)}>
        {message}
      </div>
    </Context.Provider>
  );
}

export function useBagUI() {
  const ctx = useContext(Context);
  if (!ctx) throw new Error("useBagUI must be used inside BagUIProvider");
  return ctx;
}
