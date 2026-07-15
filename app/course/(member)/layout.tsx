"use client";

import { useRouter } from "next/navigation";
import { useEffect, type ReactNode } from "react";
import { useAuth } from "@/providers/AuthProvider";

/**
 * Client-side gate for the signed-in course area. The login page lives
 * outside this route group (app/course/login), so it is never wrapped.
 * Anonymous visitors (and keyless deployments, where no session can exist)
 * are sent to the unlisted login page.
 */
export default function CourseGateLayout({ children }: { children: ReactNode }) {
  const { session, loading } = useAuth();
  const router = useRouter();

  useEffect(() => {
    if (!loading && !session) router.replace("/course/login");
  }, [loading, session, router]);

  if (loading || !session) {
    return (
      <div className="h-screen flex items-center justify-center bg-background">
        <span className="material-symbols-outlined animate-spin text-outline-variant text-3xl">
          progress_activity
        </span>
      </div>
    );
  }

  return <>{children}</>;
}
