<!-- UI rules: how the interface behaves — layout, composition, interaction states -->

# UI Rules

Behavioral and compositional rules for [PROJECT NAME]'s UI — how components are laid out, combined, and how they respond to interaction. This file does not redefine token *values* — those live in `ui-tokens.md`. Every rule here refers to a token by its **role** (`surface`, `text-primary`, `space-4`, etc.), so these rules apply unchanged no matter which Pattern (A/B/C/D) was selected in `ui-tokens.md`.

**This file governs static composition — what's on screen and how it's arranged. Interaction *feel* (hover transitions, animation timing, easing) is governed by the Design Craft Add-on if installed (Section 7.7 — emilkowalski/skills). Where a rule below needs a transition, it states a plain, non-opinionated fallback — replace it with that skill set's guidance if installed, don't run both at once.**

---

## Font

Load the project's font once, at the application root — never let a component fall back silently to a system font.

- **Web:** load via the framework's font-loading mechanism (e.g. `next/font/google`, or a single `@font-face` in the global stylesheet) in the root layout.
- **Electron/desktop:** bundle the font file with the app and declare it once via `@font-face` in the renderer's global stylesheet, loaded before any component renders.

**Invariant:** exactly one place in the codebase declares the font. If a second `@font-face` or font-loading call appears anywhere else, that's a bug, not a variant.

---

## Layout

- Page/window max content width: `[e.g. 1440px]`, centered — or, for a fixed-size desktop window, the window's actual usable content area
- Main content padding: use `space-6` on all sides as the default
- Gap between distinct sections: `space-6`
- Navigation structure: `[top navbar / sidebar / single-window desktop menu — pick one and state it]`

---

## Navigation

`[List nav items in order, if applicable — skip this section entirely for a single-window desktop app with no persistent nav]`

- Active item: `accent` color, distinguished from inactive by `[color change only / underline / left border — pick one, state it, do not leave ambiguous]`
- Inactive item: `text-secondary`
- Nav container background: `surface`, full width of its container

---

## Cards

Every distinct content section lives in a card, using the tokens established in `ui-tokens.md`:

```
background:    surface
border:        1px solid border
border-radius: [pick one radius token — state which]
padding:       space-6
```

**Invariant:** never apply a status/accent color to a card's background — color communicates state through badges, text, or a thin accent bar inside the card, never by recoloring the card surface itself.

---

## Typography Hierarchy

Three levels, used consistently. Exact sizes/weights live in `ui-tokens.md`'s Typography table — this section governs *when* each level applies:

- **Section headings** — card titles, page section titles. Used once per section, never nested.
- **Body/primary text** — the default for any readable content.
- **Secondary/muted text** — labels, timestamps, captions, anything supporting rather than primary.

**Invariant:** never introduce a fourth text size/weight combination outside these three without adding it to `ui-tokens.md`'s Typography table first — an ad hoc text style is exactly the drift `/moor` exists to catch.

---

## Badges

Pill-shaped (`radius: full`) by default. Padding: small, consistent — `[state actual value, e.g. 2px 8px]`. Any badge variant that breaks the pill shape (e.g. a status strip) must be named explicitly here, not invented ad hoc per component.

---

## Buttons

Three variants, each referencing `ui-tokens.md` roles:

- **Primary:** background `accent`, text `accent-foreground`
- **Secondary:** background `surface`, border `border`, text `text-primary`
- **Ghost:** transparent background, text `text-secondary`, `surface-secondary` on hover

**Interaction fallback (if Design Craft Add-on not installed):** a plain, non-opinionated transition on hover/focus/active state changes — a short, unremarkable fade, nothing bespoke per component. **If the Design Craft Add-on is installed, this fallback is superseded — defer to it entirely for how buttons should feel to press, not just how they look at rest.**

---

## Form Inputs

```
background:    surface
border:        1px solid border
padding:       [state value]
text:          text-primary
placeholder:   text-secondary
focus state:   1px ring in accent color
```

**Invariant:** a disabled input must be visually distinguishable from an active one using existing tokens (e.g. reduced opacity or `surface-secondary`) — never left visually identical to an enabled field.

---

## Table

- No alternating row colors — `surface` rows only, separated by a `border`-colored line between rows
- Column headers: `text-secondary`, uppercase or `[state the actual convention]`
- Row hover: `surface-secondary` background
- Row text: `text-primary`

---

## Empty States

Every section that can render with no data must have an explicit empty state — never a blank gap. Minimum: short descriptive text in `text-secondary`, optionally an icon, and a call-to-action button only if there's a real next action to take.

---

## Do Nots (apply regardless of which ui-tokens.md pattern was selected)

- Never introduce a raw color, spacing, or radius value in a component — every value traces back to a token in `ui-tokens.md`.
- Never invent a fourth typography level without adding it to the token file first.
- Never recolor a card's background to communicate status — use badges, text, or an accent bar instead.
- Never leave a disabled state visually identical to an active one.
- Never hand-write bespoke transition timing/easing per component if the Design Craft Add-on is installed — that skill set is the single source of truth for interaction feel once present.
- Never show a raw error message to the user — always a human-readable one, regardless of what the underlying system reports.

---

## Delegation note

Building a new component that follows an already-established pattern in `ui-registry.md` (a card, a button variant, a form field matching an existing one) is Junior-safe delegation material — see the `delegate` skill. **Establishing a new composition pattern for the first time — a new nav paradigm, a new card variant, anything `ui-registry.md` doesn't already have an entry for — is Senior-required**, since every future component will copy whatever gets decided here. Get it right once, deliberately, rather than delegating the precedent-setting decision.
