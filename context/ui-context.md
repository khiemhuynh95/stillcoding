---
name: Material Logic
colors:
  surface: '#f8f9fa'
  surface-dim: '#d9dadb'
  surface-bright: '#f8f9fa'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f4f5'
  surface-container: '#edeeef'
  surface-container-high: '#e7e8e9'
  surface-container-highest: '#e1e3e4'
  on-surface: '#191c1d'
  on-surface-variant: '#414754'
  inverse-surface: '#2e3132'
  inverse-on-surface: '#f0f1f2'
  outline: '#727785'
  outline-variant: '#c1c6d6'
  surface-tint: '#005bc0'
  primary: '#005bbf'
  on-primary: '#ffffff'
  primary-container: '#1a73e8'
  on-primary-container: '#ffffff'
  inverse-primary: '#adc7ff'
  secondary: '#006e2c'
  on-secondary: '#ffffff'
  secondary-container: '#86f898'
  on-secondary-container: '#00722f'
  tertiary: '#795900'
  on-tertiary: '#ffffff'
  tertiary-container: '#987000'
  on-tertiary-container: '#ffffff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d8e2ff'
  primary-fixed-dim: '#adc7ff'
  on-primary-fixed: '#001a41'
  on-primary-fixed-variant: '#004493'
  secondary-fixed: '#89fa9b'
  secondary-fixed-dim: '#6ddd81'
  on-secondary-fixed: '#002108'
  on-secondary-fixed-variant: '#005320'
  tertiary-fixed: '#ffdfa0'
  tertiary-fixed-dim: '#fbbc05'
  on-tertiary-fixed: '#261a00'
  on-tertiary-fixed-variant: '#5c4300'
  background: '#f8f9fa'
  on-background: '#191c1d'
  surface-variant: '#e1e3e4'
typography:
  headline-sm:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  body-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '400'
    lineHeight: 16px
  code-md:
    fontFamily: JetBrains Mono
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 22px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.5px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  sidebar-width: 260px
  panel-height: 200px
  gutter: 16px
  edge-margin: 8px
  stack-gap: 4px
---

## Brand & Style

This design system embodies the "Google-style" aesthetic: clean, optimistic, and highly functional. It leverages a **Corporate / Modern** style rooted in Material Design 3 principles. The interface is characterized by high legibility, purposeful use of white space, and a refined "bright and airy" atmosphere. 

The target audience is developers who value clarity over visual noise. The emotional response is one of organized productivity—a professional "blank canvas" that stays out of the way of the code while providing delightful, subtle feedback through motion and soft elevation.

## Colors

The palette is built upon the iconic Google brand colors. 
- **Primary (Google Blue):** Used for primary actions, active states, and focus indicators.
- **Surface & Background:** The UI utilizes `#ffffff` for the main editor canvas and `#f8f9fa` or `#f1f3f4` for structural containers like sidebars and panels to create subtle contrast without heavy borders.
- **Syntax Highlighting:** Highlighting should use desaturated versions of the primary/secondary/tertiary/error colors to maintain long-session comfort. 
    - Keywords: Blue (#1a73e8)
    - Strings: Green (#188038)
    - Constants/Numbers: Red (#d93025)
    - Comments: Grey (#70757a)

## Typography

The typography system uses a hierarchical approach:
- **UI Elements:** Use *Plus Jakarta Sans* for headers and *Inter* for general interface labels to provide a soft, modern humanist feel.
- **The Editor:** *JetBrains Mono* is the standard for the code editor and terminal, chosen for its exceptional readability and distinct character shapes.
- **Scale:** Maintain a tight scale for the IDE. Body text stays at 14px for density, while labels for file names and metadata drop to 12px.

## Layout & Spacing

The layout follows a **Fixed-Fluid hybrid** model:
- **Sidebar:** Fixed width (260px) on the left for file navigation. 
- **Main Area:** Fluid editor space with a tab bar at the top.
- **Bottom Panel:** Fixed height (200px) resizable drawer for the terminal.
- **Rhythm:** An 8px grid system governs all spacing. Vertical stacks in the sidebar use 4px gaps for high density, while the main editor canvas uses 16px margins to provide "breathing room."

## Elevation & Depth

This design system uses **Tonal Layers** rather than heavy shadows to define hierarchy.
- **Level 0 (Background):** The main editor canvas (#ffffff).
- **Level 1 (Surface):** Sidebars and bottom panels (#f8f9fa), separated by a 1px border (#e0e0e0) rather than a shadow.
- **Level 2 (Active/Floating):** Use a very soft ambient shadow (0px 4px 12px rgba(0,0,0,0.05)) only for floating menus, tooltips, or command palettes.
- **Active State:** The active tab is indicated by a white background and a 3px primary blue bottom-border, while inactive tabs blend into the surface color.

## Shapes

The design uses a **Soft** shape language. 
- **Buttons & Inputs:** 4px (0.25rem) corner radius to feel professional and structured.
- **Selection Highlights:** File tree selections and text highlights use a 4px radius for a cleaner, more integrated look.
- **Tabs:** Top corners are rounded (4px), while bottom corners remain sharp to sit flush with the editor container.

## Components

- **Buttons:** Primary buttons use a solid Google Blue background with white text. Secondary buttons use a tonal grey background or a simple outline. No heavy gradients.
- **Chips:** Used for language indicators or git branches in the status bar. Pill-shaped with a light grey fill and 12px Inter medium text.
- **File Tree:** High-density list. Active file uses a light blue tint (#e8f0fe) for the background and a blue font color for the label.
- **Input Fields:** Clean, underlined or lightly boxed fields with a 2px primary blue focus ring.
- **Tabs:** Should be identifiable by their icons. The active tab has a "close" 'x' visible at all times; inactive tabs show the 'x' only on hover.
- **Terminal:** Uses a slightly darker background (#202124) to visually distinguish the output zone from the coding zone, while maintaining the same mono-spaced font family.