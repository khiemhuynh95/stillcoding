"use client";

import { SidebarContent, type SidebarContentProps } from "./SidebarContent";

export function Sidebar(props: SidebarContentProps) {
  return (
    <aside className="w-sidebar-width bg-surface-container-low border-r border-outline-variant flex-col hidden lg:flex shrink-0">
      <SidebarContent {...props} />
    </aside>
  );
}
