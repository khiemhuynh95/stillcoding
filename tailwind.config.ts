import type { Config } from "tailwindcss";

// Semantic Material 3 color tokens. The actual values are CSS variables defined
// in app/globals.css (:root = light scheme, .dark = dark scheme), so toggling
// the `.dark` class on <html> flips the entire palette automatically — no
// per-element `dark:` variants required. RGB-channel form keeps Tailwind's
// opacity modifiers (e.g. `bg-primary/40`) working.
const TOKENS = [
  "primary", "primary-tint", "on-primary", "primary-container", "on-primary-container",
  "surface-tint", "inverse-primary",
  "secondary", "on-secondary", "secondary-container", "on-secondary-container",
  "tertiary", "on-tertiary", "tertiary-container", "on-tertiary-container",
  "error", "on-error", "error-container", "on-error-container",
  "background", "on-background", "surface", "on-surface", "on-surface-variant",
  "surface-variant", "surface-dim", "surface-bright",
  "surface-container-lowest", "surface-container-low", "surface-container",
  "surface-container-high", "surface-container-highest",
  "inverse-surface", "inverse-on-surface", "outline", "outline-variant",
  "primary-fixed", "primary-fixed-dim", "on-primary-fixed", "on-primary-fixed-variant",
  "secondary-fixed", "secondary-fixed-dim", "on-secondary-fixed", "on-secondary-fixed-variant",
  "tertiary-fixed", "tertiary-fixed-dim", "on-tertiary-fixed", "on-tertiary-fixed-variant",
];

const colors = Object.fromEntries(
  TOKENS.map((t) => [t, `rgb(var(--${t}) / <alpha-value>)`]),
);

const config: Config = {
  darkMode: "class",
  content: [
    "./app/**/*.{ts,tsx}",
    "./components/**/*.{ts,tsx}",
    "./hooks/**/*.{ts,tsx}",
  ],
  theme: {
    extend: {
      colors,
      // Standard Material/Tailwind radius scale per DESIGN.md (`rounded`).
      borderRadius: {
        sm: "0.125rem",
        DEFAULT: "0.25rem",
        md: "0.375rem",
        lg: "0.5rem",
        xl: "0.75rem",
        full: "9999px",
      },
      // Tonal-layer elevation: soft ambient shadow for floating surfaces only.
      boxShadow: {
        ambient: "0px 4px 12px rgba(0,0,0,0.05)",
      },
      spacing: {
        "stack-gap": "4px",
        "edge-margin": "8px",
        "sidebar-width": "260px",
        "panel-height": "200px",
        gutter: "16px",
      },
      fontFamily: {
        "label-md": ["Inter", "sans-serif"],
        "headline-sm": ["Plus Jakarta Sans", "sans-serif"],
        "code-md": ["JetBrains Mono", "monospace"],
        "body-sm": ["Inter", "sans-serif"],
        "body-md": ["Inter", "sans-serif"],
      },
      fontSize: {
        "label-md": [
          "12px",
          { lineHeight: "16px", letterSpacing: "0.5px", fontWeight: "500" },
        ],
        "headline-sm": ["20px", { lineHeight: "28px", fontWeight: "600" }],
        "code-md": ["14px", { lineHeight: "22px", fontWeight: "400" }],
        "body-sm": ["12px", { lineHeight: "16px", fontWeight: "400" }],
        "body-md": ["14px", { lineHeight: "20px", fontWeight: "400" }],
      },
    },
  },
  plugins: [],
};

export default config;
