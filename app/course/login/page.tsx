"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { useEffect, useState } from "react";
import { useAuth } from "@/providers/AuthProvider";
import { supabaseEnabled } from "@/lib/supabase";
import { joinCourse } from "@/lib/course";
import { cn } from "@/lib/utils";

/**
 * Unlisted sign-in / registration page for the course beta. Nothing in the
 * public app links here — participants get the URL from a course admin.
 * Registering with a course ID (join code) enrolls immediately; invited
 * emails are auto-enrolled by the DB trigger regardless.
 */
export default function CourseLoginPage() {
  const router = useRouter();
  const { session, loading, signIn, signUp, resetPassword } = useAuth();

  const [mode, setMode] = useState<"signin" | "register">("signin");
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [displayName, setDisplayName] = useState("");
  const [joinCode, setJoinCode] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [notice, setNotice] = useState<string | null>(null);
  const [busy, setBusy] = useState(false);

  const handleForgotPassword = async () => {
    if (busy) return;
    setError(null);
    setNotice(null);
    const address = email.trim();
    if (!address) {
      setError("Enter your email above first, then click Forgot password.");
      return;
    }
    setBusy(true);
    try {
      const { error: err } = await resetPassword(address);
      if (err) setError(err);
      else setNotice(`Password reset link sent to ${address}. Check your inbox.`);
    } finally {
      setBusy(false);
    }
  };

  // Already signed in — go straight to the course dashboard.
  useEffect(() => {
    if (!loading && session) router.replace("/course");
  }, [loading, session, router]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (busy) return;
    setError(null);
    setNotice(null);
    setBusy(true);
    try {
      if (mode === "register") {
        const name = displayName.trim();
        if (!name) {
          setError("Display name is required.");
          return;
        }
        const { error: err } = await signUp(email.trim(), password, name);
        if (err) {
          setError(err);
          return;
        }
        // Enroll with the provided course ID (best-effort — the account is
        // created either way; a bad code just surfaces its message).
        if (joinCode.trim()) {
          try {
            await joinCourse(joinCode);
          } catch (e) {
            setError(e instanceof Error ? e.message : "Could not join course");
            return;
          }
        }
      } else {
        const { error: err } = await signIn(email.trim(), password);
        if (err) {
          setError(err);
          return;
        }
      }
      router.replace("/course");
    } finally {
      setBusy(false);
    }
  };

  if (!supabaseEnabled) {
    return (
      <div className="h-screen flex flex-col items-center justify-center text-center px-6 gap-4 bg-background">
        <span className="material-symbols-outlined text-6xl text-outline-variant">
          school
        </span>
        <h1 className="font-headline-sm text-headline-sm text-on-surface">
          Courses are not available
        </h1>
        <p className="text-body-md text-on-surface-variant max-w-sm">
          This deployment isn&apos;t configured for the course beta.
        </p>
        <Link
          href="/"
          className="px-5 py-2.5 bg-primary text-on-primary rounded text-label-md font-label-md hover:opacity-90"
        >
          Back to browse
        </Link>
      </div>
    );
  }

  return (
    <div className="min-h-screen flex items-center justify-center px-4 bg-background">
      <div className="w-full max-w-sm bg-surface-container-lowest border border-outline-variant rounded-lg p-6 flex flex-col gap-4">
        <div className="text-center">
          <span className="text-headline-sm font-headline-sm font-bold text-primary">
            StillCoding
          </span>
          <p className="mt-1 text-body-sm text-on-surface-variant">
            LeetCoding course · beta
          </p>
        </div>

        <div className="flex rounded border border-outline-variant overflow-hidden">
          {(["signin", "register"] as const).map((m) => (
            <button
              key={m}
              type="button"
              onClick={() => {
                setMode(m);
                setError(null);
                setNotice(null);
              }}
              className={cn(
                "flex-1 py-2 text-label-md font-label-md transition-colors",
                mode === m
                  ? "bg-primary text-on-primary"
                  : "text-on-surface-variant hover:bg-surface-container",
              )}
            >
              {m === "signin" ? "Sign in" : "Register"}
            </button>
          ))}
        </div>

        <form onSubmit={handleSubmit} className="flex flex-col gap-3">
          {mode === "register" && (
            <input
              type="text"
              value={displayName}
              onChange={(e) => setDisplayName(e.target.value)}
              placeholder="Display name"
              autoComplete="name"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
          )}
          <input
            type="email"
            required
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="Email"
            autoComplete="email"
            className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
          />
          <input
            type="password"
            required
            minLength={6}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
            placeholder="Password"
            autoComplete={mode === "register" ? "new-password" : "current-password"}
            className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
          />
          {mode === "register" && (
            <input
              type="text"
              value={joinCode}
              onChange={(e) => setJoinCode(e.target.value)}
              placeholder="Course ID (optional)"
              autoComplete="off"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
          )}

          {error && (
            <p className="text-body-sm text-error" role="alert">
              {error}
            </p>
          )}
          {notice && (
            <p className="text-body-sm text-on-secondary-container" role="status">
              {notice}
            </p>
          )}

          <button
            type="submit"
            disabled={busy}
            className="mt-1 py-2.5 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {busy
              ? "Working…"
              : mode === "signin"
                ? "Sign in"
                : "Create account"}
          </button>

          {mode === "signin" && (
            <button
              type="button"
              onClick={() => void handleForgotPassword()}
              className="self-center text-body-sm text-on-surface-variant hover:text-primary transition-colors"
            >
              Forgot password?
            </button>
          )}
        </form>

        <p className="text-center text-body-sm text-on-surface-variant">
          Invited by email? Just register with that address — you&apos;ll be
          enrolled automatically.
        </p>
      </div>
    </div>
  );
}
