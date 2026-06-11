/** Slim app footer (matches the coding-screen mockup footer). */
export function Footer() {
  return (
    <footer className="bg-surface-dim border-t border-outline-variant w-full py-2 px-edge-margin flex justify-between items-center shrink-0">
      <span className="font-body-sm text-body-sm text-on-surface-variant">
        © 2024 StillCoding. All rights reserved.
      </span>
      <div className="hidden sm:flex items-center gap-4">
        {["Support", "Privacy", "Terms", "API"].map((label) => (
          <span
            key={label}
            className="font-body-sm text-body-sm text-on-surface-variant hover:text-primary transition-colors cursor-pointer"
          >
            {label}
          </span>
        ))}
      </div>
    </footer>
  );
}
