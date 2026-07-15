"use client";

import type { Session, User } from "@supabase/supabase-js";
import {
  createContext,
  useContext,
  useEffect,
  useState,
  type ReactNode,
} from "react";
import { supabaseClient, supabaseEnabled } from "@/lib/supabase";
import type { Profile } from "@/lib/types";

/**
 * Supabase Auth session for the hidden course beta. Wraps the whole app (see
 * app/layout.tsx) but is inert for anonymous visitors and when Supabase env
 * vars are unset — no session exists, nothing is fetched, and the public app
 * behaves exactly as before. Sign-in happens only on the unlisted
 * /course/login page.
 */

interface AuthContextValue {
  session: Session | null;
  user: User | null;
  profile: Profile | null;
  /** True until the initial session restore has resolved. */
  loading: boolean;
  signIn: (email: string, password: string) => Promise<{ error: string | null }>;
  signUp: (
    email: string,
    password: string,
    displayName: string,
  ) => Promise<{ error: string | null }>;
  signOut: () => Promise<void>;
  /** Sends a password-recovery email linking to /course/reset-password. */
  resetPassword: (email: string) => Promise<{ error: string | null }>;
  /** Sets a new password for the signed-in (or recovery) session. */
  updatePassword: (password: string) => Promise<{ error: string | null }>;
  /** Updates profiles.display_name (the name other members see). */
  updateDisplayName: (name: string) => Promise<{ error: string | null }>;
}

const NOT_CONFIGURED = { error: "Auth is not configured" };

const AuthContext = createContext<AuthContextValue>({
  session: null,
  user: null,
  profile: null,
  loading: false,
  signIn: async () => NOT_CONFIGURED,
  signUp: async () => NOT_CONFIGURED,
  signOut: async () => {},
  resetPassword: async () => NOT_CONFIGURED,
  updatePassword: async () => NOT_CONFIGURED,
  updateDisplayName: async () => NOT_CONFIGURED,
});

async function fetchProfile(userId: string): Promise<Profile | null> {
  if (!supabaseClient) return null;
  const { data, error } = await supabaseClient
    .from("profiles")
    .select("id, display_name, is_admin")
    .eq("id", userId)
    .maybeSingle();
  if (error || !data) return null;
  return {
    id: data.id as string,
    displayName: (data.display_name as string) ?? "",
    isAdmin: (data.is_admin as boolean) ?? false,
  };
}

export function AuthProvider({ children }: { children: ReactNode }) {
  const [session, setSession] = useState<Session | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(supabaseEnabled);

  useEffect(() => {
    if (!supabaseClient) return;
    let cancelled = false;

    // Restores the persisted session (if any), then tracks auth changes.
    supabaseClient.auth.getSession().then(({ data }) => {
      if (cancelled) return;
      setSession(data.session);
      setLoading(false);
    });

    const { data: sub } = supabaseClient.auth.onAuthStateChange(
      (_event, next) => {
        if (cancelled) return;
        setSession(next);
      },
    );

    return () => {
      cancelled = true;
      sub.subscription.unsubscribe();
    };
  }, []);

  // Load the profile row whenever the signed-in user changes, and redeem any
  // invites created after this user registered (fire-and-forget).
  const userId = session?.user?.id ?? null;
  useEffect(() => {
    if (!supabaseClient || !userId) {
      setProfile(null);
      return;
    }
    let cancelled = false;
    fetchProfile(userId).then((p) => {
      if (!cancelled) setProfile(p);
    });
    supabaseClient.rpc("redeem_invites").then(() => {});
    return () => {
      cancelled = true;
    };
  }, [userId]);

  const signIn = async (email: string, password: string) => {
    if (!supabaseClient) return { error: "Auth is not configured" };
    const { error } = await supabaseClient.auth.signInWithPassword({
      email,
      password,
    });
    return { error: error?.message ?? null };
  };

  const signUp = async (email: string, password: string, displayName: string) => {
    if (!supabaseClient) return { error: "Auth is not configured" };
    const { error } = await supabaseClient.auth.signUp({
      email,
      password,
      // Picked up by the handle_new_user trigger for the profiles row.
      options: { data: { display_name: displayName } },
    });
    return { error: error?.message ?? null };
  };

  const signOut = async () => {
    if (!supabaseClient) return;
    await supabaseClient.auth.signOut();
  };

  const resetPassword = async (email: string) => {
    if (!supabaseClient) return NOT_CONFIGURED;
    const { error } = await supabaseClient.auth.resetPasswordForEmail(email, {
      redirectTo: `${window.location.origin}/course/reset-password`,
    });
    return { error: error?.message ?? null };
  };

  const updatePassword = async (password: string) => {
    if (!supabaseClient) return NOT_CONFIGURED;
    const { error } = await supabaseClient.auth.updateUser({ password });
    return { error: error?.message ?? null };
  };

  const updateDisplayName = async (name: string) => {
    if (!supabaseClient || !userId) return NOT_CONFIGURED;
    const trimmed = name.trim();
    if (!trimmed) return { error: "Display name is required" };
    const { error } = await supabaseClient
      .from("profiles")
      .update({ display_name: trimmed })
      .eq("id", userId);
    if (error) return { error: error.message };
    setProfile((p) => (p ? { ...p, displayName: trimmed } : p));
    return { error: null };
  };

  return (
    <AuthContext.Provider
      value={{
        session,
        user: session?.user ?? null,
        profile,
        loading,
        signIn,
        signUp,
        signOut,
        resetPassword,
        updatePassword,
        updateDisplayName,
      }}
    >
      {children}
    </AuthContext.Provider>
  );
}

export function useAuth() {
  return useContext(AuthContext);
}
