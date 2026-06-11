"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import { cn } from "@/lib/utils";

/** Bottom navigation shown on small screens. */
export function MobileNav() {
  const pathname = usePathname();
  const browseActive = pathname === "/" || pathname.startsWith("/problems");
  const roadmapActive = pathname.startsWith("/roadmap");

  return (
    <div className="md:hidden fixed bottom-0 left-0 right-0 bg-surface-container-lowest border-t border-outline-variant px-4 py-2 flex justify-around items-center z-50">
      <Link
        href="/"
        className={cn(
          "flex flex-col items-center gap-1",
          browseActive ? "text-primary" : "text-on-surface-variant",
        )}
      >
        <span className={cn("material-symbols-outlined", browseActive && "fill")}>
          explore
        </span>
        <span className={cn("text-[10px]", browseActive && "font-bold")}>
          Browse
        </span>
      </Link>
      <Link
        href="/roadmap"
        className={cn(
          "flex flex-col items-center gap-1",
          roadmapActive ? "text-primary" : "text-on-surface-variant",
        )}
      >
        <span className={cn("material-symbols-outlined", roadmapActive && "fill")}>
          route
        </span>
        <span className={cn("text-[10px]", roadmapActive && "font-bold")}>
          Roadmap
        </span>
      </Link>
      {[
        { icon: "forum", label: "Discuss" },
        { icon: "account_circle", label: "Profile" },
      ].map((item) => (
        <button
          key={item.label}
          type="button"
          className="flex flex-col items-center gap-1 text-on-surface-variant"
        >
          <span className="material-symbols-outlined">{item.icon}</span>
          <span className="text-[10px]">{item.label}</span>
        </button>
      ))}
    </div>
  );
}
