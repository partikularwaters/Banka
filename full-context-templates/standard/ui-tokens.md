<!-- UI tokens: the design system values the agent must use for all styling -->

# UI Tokens

Design tokens for [PROJECT NAME]. Colors, typography, spacing, and component values — the static visual vocabulary every component draws from. Never hardcode a color, spacing value, or radius directly in a component; always reference a named token.

**This file governs static values only — color, type, spacing, shape.** If the Design Craft Add-on (emilkowalski/skills) is installed for this project, motion, animation timing, and interaction feel are governed there instead, not here — see the note at the end of this file.

---

## How to fill this file in (read before writing anything below)

This file has no single correct stack. Below are four fully committed,
contrasting patterns — pick the one that matches this project's real stack,
delete the others, and fill in real values. Do not write a soft paragraph meant
to cover all four; half-committing to four stacks constrains nothing.

If none of the four patterns match this project's actual stack, build one in the same spirit: real syntax, real file location, a real "never do X" invariant — not an abstract placeholder.

---

## Pattern A — Web, Tailwind CSS v4

Use if the project is a Next.js/React/Vite web app styled with Tailwind.

Tokens are defined via the `@theme` directive in `app/globals.css` (or equivalent). Tailwind v4 auto-generates utility classes from `@theme` variables — `--color-accent` becomes `bg-accent`, `text-accent`, `border-accent`.

```css
@import "tailwindcss";

@theme {
  --font-sans: "[YOUR FONT]", sans-serif;
  --color-background: [e.g. #F6F7FB];
  --color-surface: [e.g. #FFFFFF];
  --color-border: [e.g. #E7EAF3];
  --color-text-primary: [e.g. #101828];
  --color-text-secondary: [e.g. #6A7282];
  --color-accent: [e.g. #7C5CFC];
  --color-accent-foreground: [e.g. #FFFFFF];
  --color-success: [e.g. #10B981];
  --color-warning: [e.g. #FF8904];
  --color-error: [e.g. #EF4444];
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
}
```

```tsx
// Correct
className="bg-surface text-text-primary border-border"
// Never
className="bg-[#F6F7FB]"        // hardcoded hex
className="bg-purple-500"       // raw Tailwind color, bypasses the token system
```

**Invariant:** never define colors in `tailwind.config.ts` — `@theme` in globals.css is the only source.

---

## Pattern B — Web or cross-platform, framework-agnostic (CSS custom properties)

Use if the project doesn't use Tailwind — plain CSS, CSS Modules, styled-components, or any setup where a global token file makes more sense than a utility-class framework.

```css
/* tokens.css — imported once, at the root */
:root {
  --font-sans: "[YOUR FONT]", sans-serif;
  --color-background: [e.g. #F6F7FB];
  --color-surface: [e.g. #FFFFFF];
  --color-border: [e.g. #E7EAF3];
  --color-text-primary: [e.g. #101828];
  --color-text-secondary: [e.g. #6A7282];
  --color-accent: [e.g. #7C5CFC];
  --color-accent-foreground: [e.g. #FFFFFF];
  --color-success: [e.g. #10B981];
  --color-warning: [e.g. #FF8904];
  --color-error: [e.g. #EF4444];
  --radius-sm: 4px;
  --radius-md: 8px;
  --radius-lg: 12px;
  --space-2: 8px;
  --space-4: 16px;
  --space-6: 24px;
}
```

```css
/* Correct — component CSS references the variable */
.card { background: var(--color-surface); border: 1px solid var(--color-border); }
/* Never — a component file defines its own color */
.card { background: #FFFFFF; }
```

**Invariant:** every component stylesheet imports from `tokens.css` — no component ever declares a raw hex value or magic-number spacing value.

---

## Pattern C — Desktop (Electron) or native UI, no CSS utility framework

Use if the project is a desktop app (Electron, Tauri) or otherwise renders outside a web-utility-class ecosystem. Tokens still live in one place, but "one place" is usually a shared TS/JS constants module or a CSS custom-properties file loaded once in the renderer, not a Tailwind config.

```typescript
// src/shared/theme.ts — imported by every component, never duplicated
export const theme = {
  font: { sans: "[YOUR FONT]" },
  color: {
    background: "[e.g. #F6F7FB]",
    surface: "[e.g. #FFFFFF]",
    border: "[e.g. #E7EAF3]",
    textPrimary: "[e.g. #101828]",
    textSecondary: "[e.g. #6A7282]",
    accent: "[e.g. #7C5CFC]",
    accentForeground: "[e.g. #FFFFFF]",
    success: "[e.g. #10B981]",
    warning: "[e.g. #FF8904]",
    error: "[e.g. #EF4444]",
  },
  radius: { sm: "4px", md: "8px", lg: "12px" },
  space: { 2: "8px", 4: "16px", 6: "24px" },
} as const;
```

```tsx
// Correct
<div style={{ background: theme.color.surface, borderRadius: theme.radius.md }} />
// Never — a component hardcodes its own value
<div style={{ background: "#FFFFFF" }} />
```

**Invariant:** `theme.ts` is the single import path for every color/spacing/radius value across the renderer process — no component defines its own.

---

## Pattern D — Web, shadcn/ui (built on Tailwind + Radix primitives)

Use if the project uses shadcn/ui. This isn't a separate styling system from Pattern A — it's Tailwind underneath, plus a CLI-installed component layer with its own token convention. Worth its own pattern because the convention differs from a hand-rolled Tailwind setup in a few specific ways.

**Key differences from Pattern A:**
- Tokens follow a **semantic background/foreground pairing convention** (`background`/`foreground`, `primary`/`primary-foreground`, `card`/`card-foreground`, etc.) rather than a flat list of names — every surface color has a matching "what text/icon color sits on top of it" partner.
- As of current shadcn/ui + Tailwind v4, color values are defined in **OKLCH**, not hex or HSL — this is a real, current convention, not a stylistic choice to swap freely.
- A single `--radius` base value drives the entire radius scale via `calc()`, rather than independent sm/md/lg values — changing one number updates every corner in the app consistently.
- Configuration lives in `components.json` (generated by the shadcn CLI on init), which controls whether theming uses CSS variables or plain utility classes — CSS variables is the default and the recommended path.

```css
/* app/globals.css */
:root {
  --background: oklch(1 0 0);
  --foreground: oklch(0.145 0.015 285.823);
  --primary: [e.g. oklch(0.488 0.243 264.376)];
  --primary-foreground: oklch(1 0 0);
  --border: [oklch value];
  --radius: 0.5rem;
}
.dark {
  --background: [oklch value];
  --foreground: [oklch value];
  /* ...every token gets a dark-mode override here */
}

@theme inline {
  --color-background: var(--background);
  --color-foreground: var(--foreground);
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
  --color-border: var(--border);
  --radius-sm: calc(var(--radius) * 0.6);
  --radius-md: calc(var(--radius) * 0.8);
  --radius-lg: var(--radius);
}
```

```tsx
// Correct — semantic pair used together
<div className="bg-background text-foreground" />
<button className="bg-primary text-primary-foreground" />
// Never — mixing a semantic background with a raw/unrelated text color
<div className="bg-background text-gray-600" />
```

**Invariant:** never edit a shadcn component's source file directly to change its look — override the token values in `globals.css` instead, or the next `shadcn` CLI update will conflict with your changes. New colors get added as a background/foreground pair, in both `:root` and `.dark`, then exposed via `@theme inline` — never as a one-off utility class.

**Component selection, not just tokens:** shadcn/ui is a component library as
much as a token system. If an external Design Craft Add-on with a
`pick-ui-library` skill is installed, it governs which component to use. This
file governs the tokens those components consume, not component selection.

---

## Color Usage Guide (fill in after picking a pattern above)

| Element                | Token role         |
| ------------------------ | -------------------- |
| Page background        | background          |
| Card / surface         | surface             |
| Default border          | border              |
| Primary text            | text-primary        |
| Secondary/label text   | text-secondary      |
| Primary button bg      | accent              |
| Primary button text    | accent-foreground   |
| Success state           | success             |
| Warning state           | warning             |
| Error state              | error               |

## Typography

| Element           | Size | Weight     | Color role     |
| ------------------ | ---- | ---------- | ---------------- |
| Page heading      | [px] | [weight]   | text-primary    |
| Section heading   | [px] | [weight]   | text-primary    |
| Body text         | [px] | [weight]   | text-primary    |
| Label             | [px] | [weight]   | text-secondary  |
| Muted / timestamp | [px] | [weight]   | text-secondary  |

Font: **[YOUR FONT]** — load it once, at the app root. Never fall back to a bare system font silently.

## Spacing Scale

Commit to real starting numbers now and revise once real UI exists. Do not leave
this as an abstract placeholder.

| Token | Value | Usage |
| ----- | ----- | ----- |
| space-2 | 8px | Tight gaps — badge/tag spacing |
| space-4 | 16px | Standard internal padding |
| space-6 | 24px | Between distinct sections |

## Component Tokens

Fill in using whichever pattern (A/B/C/D) was selected above — same values, expressed in that pattern's syntax.

**Cards:** background = surface, border = 1px solid border-color, radius = [pick from scale], padding = space-4 or space-6

**Buttons (primary):** background = accent, text = accent-foreground, radius = [pick], padding = [pick]

**Inputs:** background = surface, border = 1px solid border-color, radius = [pick], focus state = 1px ring in accent color

---

## Invariants (apply regardless of which pattern was chosen above)

- Never hardcode a hex value, RGB value, or magic-number spacing value directly in a component file — always reference the token source.
- Every new color or spacing value gets added to the token source first, then used — never invented inline "just this once."
- If this project has an external Design Craft Add-on installed, that skill set
  governs animation timing, easing, and interaction feel. This file governs
  static values only; do not let animation values drift into it.
- Building or updating a component's tokens is Junior-safe delegation material (see the `delegate` skill) *only* when it's matching an already-established pattern from `ui-registry.md` — establishing a new token category for the first time is Senior-required, since it sets a precedent every future component will copy.
