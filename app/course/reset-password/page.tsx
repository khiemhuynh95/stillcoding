"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useState } from "react";
import { useAuth } from "@/providers/AuthProvider";

/**
 * Landing page for the password-recovery email link. Opening the link signs
 * the user in with a recovery session (supabase-js picks the token out of the
 * URL automatically), so all this page does is set the new password. Reached
 * only from the email — nothing links here.
 */
export default function ResetPasswordPage() {
  const router = useRouter();
  const { session, loading, updatePassword } = useAuth();

  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (busy) return;
    setError(null);
    if (password.length < 6) {
      setError("Password must be at least 6 characters.");
      return;
    }
    if (password !== confirm) {
      setError("Passwords don't match.");
      return;
    }
    setBusy(true);
    try {
      const { error: err } = await updatePassword(password);
      if (err) {
        setError(err);
        return;
      }
      router.replace("/course");
    } finally {
      setBusy(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center px-4 bg-background">
      <div className="w-full max-w-sm bg-surface-container-lowest border border-outline-variant rounded-lg p-6 flex flex-col gap-4">
        <div className="text-center">
          <span className="text-headline-sm font-headline-sm font-bold text-primary">
            StillCoding
          </span>
          <p className="mt-1 text-body-sm text-on-surface-variant">
            Set a new password
          </p>
        </div>

        {loading ? (
          <p className="text-center text-body-sm text-on-surface-variant">
            Checking your reset link…
          </p>
        ) : !session ? (
          <>
            <p className="text-center text-body-sm text-on-surface-variant">
              This page only works when opened from a password-reset email
              link (links expire after a while).
            </p>
            <Link
              href="/course/login"
              className="self-center px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90"
            >
              Back to sign in
            </Link>
          </>
        ) : (
          <form onSubmit={handleSubmit} className="flex flex-col gap-3">
            <input
              type="password"
              required
              minLength={6}
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="New password"
              autoComplete="new-password"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
            <input
              type="password"
              required
              minLength={6}
              value={confirm}
              onChange={(e) => setConfirm(e.target.value)}
              placeholder="Repeat new password"
              autoComplete="new-password"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
            {error && (
              <p className="text-body-sm text-error" role="alert">
                {error}
              </p>
            )}
            <button
              type="submit"
              disabled={busy}
              className="mt-1 py-2.5 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 disabled:cursor-not-allowed"
            >
              {busy ? "Saving…" : "Set new password"}
            </button>
          </form>
        )}
      </div>
    </div>
  );
}
