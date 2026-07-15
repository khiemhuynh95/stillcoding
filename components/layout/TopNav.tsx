"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { useEffect, type ReactNode } from "react";
import { useLocalStorage } from "@/hooks/useLocalStorage";
import { storageKeys } from "@/lib/storage";
import { useAuth } from "@/providers/AuthProvider";
import { cn } from "@/lib/utils";

/** Shared top navigation bar. Pages pass their own right-side `actions`. */
const NAV_LINKS = [
  { href: "/", label: "Browse" },
  { href: "/roadmap", label: "Roadmap" },
];

export function TopNav({ actions }: { actions?: ReactNode }) {
  const pathname = usePathname();
  const { session, profile } = useAuth();
  // The course area is an unlisted beta: the nav entry appears only for
  // signed-in users, so the public app never links to it.
  const navLinks = session
    ? [...NAV_LINKS, { href: "/course", label: "My Courses" }]
    : NAV_LINKS;
  const [theme, setTheme, hydrated] = useLocalStorage<"light" | "dark">(
    storageKeys.theme,
    "light",
  );

  // Only sync the class after hydration so we don't clobber the pre-paint
  // inline script (app/layout.tsx) that already applied the stored theme.
  useEffect(() => {
    if (hydrated) {
      document.documentElement.classList.toggle("dark", theme === "dark");
    }
  }, [theme, hydrated]);

  return (
    <header className="bg-surface-container-lowest border-b border-outline-variant flex justify-between items-center w-full px-edge-margin h-14 shrink-0 z-50">
      <div className="flex items-center gap-6 pl-2">
        <Link
          href="/"
          className="text-headline-sm font-headline-sm font-bold text-primary"
        >
          StillCoding
        </Link>
        <nav className="hidden md:flex gap-1 items-center h-14">
          {navLinks.map((item) => {
            const active =
              item.href === "/"
                ? pathname === "/" || pathname.startsWith("/problems")
                : pathname.startsWith(item.href);
            return (
              <Link
                key={item.href}
                href={item.href}
                className={cn(
                  "font-body-md text-body-md h-full flex items-center px-2",
                  active
                    ? "text-primary border-b-[3px] border-primary"
                    : "text-on-surface-variant hover:text-on-surface",
                )}
              >
                {item.label}
              </Link>
            );
          })}
        </nav>
      </div>
      <div className="flex items-center gap-2 pr-1">
        {actions}
        {/* Signed-in course users: profile chip (display name → profile page). */}
        {session && (
          <Link
            href="/course/profile"
            title="Your profile"
            className="flex items-center gap-1 px-2 py-1.5 rounded-full text-body-sm text-on-surface-variant hover:text-on-surface hover:bg-surface-container transition-colors"
          >
            <span className="material-symbols-outlined text-[20px]">
              account_circle
            </span>
            <span className="hidden sm:inline max-w-32 truncate">
              {profile?.displayName}
            </span>
          </Link>
        )}
        <button
          type="button"
          onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
          aria-label="Toggle theme"
          className="material-symbols-outlined text-on-surface-variant p-2 hover:bg-surface-container rounded-full transition-colors"
        >
          {theme === "dark" ? "light_mode" : "dark_mode"}
        </button>
      </div>
    </header>
  );
}
