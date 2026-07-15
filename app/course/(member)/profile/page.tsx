"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { TopNav } from "@/components/layout/TopNav";
import { useAuth } from "@/providers/AuthProvider";

/**
 * The signed-in user's profile: the display name other members see (on
 * rosters and leaderboards) and an in-app password change (no email round
 * trip needed while signed in).
 */
export default function ProfilePage() {
  const { user, profile, updateDisplayName, updatePassword } = useAuth();

  const [name, setName] = useState("");
  const [nameNotice, setNameNotice] = useState<string | null>(null);
  const [nameError, setNameError] = useState<string | null>(null);
  const [nameBusy, setNameBusy] = useState(false);

  const [password, setPassword] = useState("");
  const [confirm, setConfirm] = useState("");
  const [pwNotice, setPwNotice] = useState<string | null>(null);
  const [pwError, setPwError] = useState<string | null>(null);
  const [pwBusy, setPwBusy] = useState(false);

  useEffect(() => {
    if (profile) setName(profile.displayName);
  }, [profile]);

  const handleSaveName = async () => {
    if (nameBusy) return;
    setNameError(null);
    setNameNotice(null);
    setNameBusy(true);
    try {
      const { error } = await updateDisplayName(name);
      if (error) setNameError(error);
      else setNameNotice("Display name updated.");
    } finally {
      setNameBusy(false);
    }
  };

  const handleChangePassword = async (e: React.FormEvent) => {
    e.preventDefault();
    if (pwBusy) return;
    setPwError(null);
    setPwNotice(null);
    if (password.length < 6) {
      setPwError("Password must be at least 6 characters.");
      return;
    }
    if (password !== confirm) {
      setPwError("Passwords don't match.");
      return;
    }
    setPwBusy(true);
    try {
      const { error } = await updatePassword(password);
      if (error) {
        setPwError(error);
        return;
      }
      setPassword("");
      setConfirm("");
      setPwNotice("Password changed.");
    } finally {
      setPwBusy(false);
    }
  };

  return (
    <div className="min-h-screen flex flex-col bg-background">
      <TopNav
        actions={
          <Link
            href="/course"
            className="px-3 py-1.5 rounded border border-outline-variant text-label-md font-label-md text-on-surface-variant hover:border-primary hover:text-on-surface transition-colors"
          >
            My courses
          </Link>
        }
      />

      <main className="flex-1 w-full max-w-lg mx-auto px-gutter py-8 flex flex-col gap-6">
        <h1 className="font-headline-sm text-headline-sm text-on-surface">
          Your profile
        </h1>

        <section className="bg-surface-container-lowest border border-outline-variant rounded-lg p-4 flex flex-col gap-3">
          <div className="flex flex-col gap-1">
            <span className="text-body-sm text-on-surface-variant">Email</span>
            <span className="text-body-md text-on-surface">{user?.email}</span>
            <span className="text-body-sm text-on-surface-variant/70">
              Used to sign in and to reset your password.
            </span>
          </div>
        </section>

        <section className="bg-surface-container-lowest border border-outline-variant rounded-lg p-4 flex flex-col gap-3">
          <label className="flex flex-col gap-1 text-body-sm text-on-surface-variant">
            Display name
            <input
              type="text"
              value={name}
              onChange={(e) => setName(e.target.value)}
              placeholder="How other members see you"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
          </label>
          <p className="text-body-sm text-on-surface-variant">
            Shown on course rosters and leaderboards.
          </p>
          {nameError && (
            <p className="text-body-sm text-error" role="alert">
              {nameError}
            </p>
          )}
          {nameNotice && (
            <p className="text-body-sm text-on-secondary-container" role="status">
              {nameNotice}
            </p>
          )}
          <button
            type="button"
            onClick={() => void handleSaveName()}
            disabled={
              nameBusy || !name.trim() || name.trim() === profile?.displayName
            }
            className="self-start px-4 py-2 rounded bg-primary text-on-primary text-label-md font-label-md hover:opacity-90 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {nameBusy ? "Saving…" : "Save name"}
          </button>
        </section>

        <section className="bg-surface-container-lowest border border-outline-variant rounded-lg p-4">
          <form onSubmit={handleChangePassword} className="flex flex-col gap-3">
            <span className="text-body-sm text-on-surface-variant">
              Change password
            </span>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="New password"
              autoComplete="new-password"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
            <input
              type="password"
              value={confirm}
              onChange={(e) => setConfirm(e.target.value)}
              placeholder="Repeat new password"
              autoComplete="new-password"
              className="bg-surface-container-lowest border border-outline-variant rounded px-3 py-2 text-body-md text-on-surface outline-none focus:ring-2 focus:ring-primary"
            />
            {pwError && (
              <p className="text-body-sm text-error" role="alert">
                {pwError}
              </p>
            )}
            {pwNotice && (
              <p className="text-body-sm text-on-secondary-container" role="status">
                {pwNotice}
              </p>
            )}
            <button
              type="submit"
              disabled={pwBusy || !password || !confirm}
              className="self-start px-4 py-2 rounded border border-outline-variant text-label-md font-label-md text-on-surface hover:border-primary disabled:opacity-40 disabled:cursor-not-allowed"
            >
              {pwBusy ? "Saving…" : "Change password"}
            </button>
          </form>
        </section>
      </main>
    </div>
  );
}
