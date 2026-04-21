# Design System Specification: The Illuminated Digital Archive

## 1. Overview & Creative North Star
**Creative North Star: "The Modern Scholar"**

This design system is a bridge between historic academic prestige and contemporary digital minimalism. It rejects the "app-like" genericism of heavy borders and flat grids, opting instead for an **Editorial Luxury** approach. The visual language is inspired by the composition of an illuminated manuscript: vast white space, authoritative typography, and gold used not as a mere decoration, but as a beacon of importance.

We achieve a signature look by breaking the traditional container-based layout. Use **intentional asymmetry**—such as off-center typography or overlapping image elements—to create a sense of bespoke curation. The user should feel they are navigating a high-end digital gallery rather than a standard utility.

---

## 2. Colors: Tonal Depth & Gold Accents
The palette is rooted in high-contrast prestige. We use deep slates and blacks to provide gravity, while the gold accents (`primary: #775a19`) provide a sense of warmth and value.

### The "No-Line" Rule
To maintain a premium, seamless feel, **1px solid borders are prohibited for sectioning.** Boundaries must be defined through background color shifts. 
- Use `surface` (`#faf9f8`) for the main canvas.
- Transition to `surface_container_low` (`#f4f3f2`) for a sidebar or secondary section.
- This creates a sophisticated, "silent" hierarchy that guides the eye without visual clutter.

### Surface Hierarchy & Nesting
Treat the UI as physical layers of fine paper. 
- **Base:** `surface`
- **Raised Elements:** `surface_container_lowest` (`#ffffff`) for cards to create a "pop" against the off-white background.
- **Sunken Elements:** `surface_container_high` (`#e9e8e7`) for search bars or inset areas.

### The "Glass & Gold" Rule
For floating navigation or top bars, use **Glassmorphism**. Apply a semi-transparent `surface` color with a 20px backdrop-blur. 
- **Signature Texture:** When using primary CTAs, apply a subtle linear gradient from `primary` (`#775a19`) to `primary_container` (`#c5a059`). This adds "visual soul," mimicking the way light hits physical gold leaf.

---

## 3. Typography: The Academic Voice
**Font: Plus Jakarta Sans**

The typography is the backbone of this system’s authority. We use a high-contrast scale to emphasize an editorial feel.

- **Display (Large/Medium):** Reserved for hero moments. Use `display-lg` (3.5rem) with a tight `letter-spacing: -0.02em` to feel modern yet imposing.
- **Headlines:** These function as "chapter titles." Always use `on_surface` (`#1a1c1c`) to ensure the black-and-gold contrast is maintained.
- **Labels & Captions:** Use `label-md` or `label-sm` in `secondary` (`#5f5e5e`) for metadata, ensuring they don't compete with the primary narrative.
- **RTL Considerations:** Plus Jakarta Sans must be paired with a high-quality Arabic typeface (like IBM Plex Sans Arabic) that matches the x-height. Ensure logical padding flips (e.g., `padding-left` becomes `padding-right`) to maintain the intentional asymmetry in RTL layouts.

---

## 4. Elevation & Depth: Tonal Layering
Traditional "drop shadows" are often too heavy for an academic aesthetic. We use **Ambient Elevation.**

### The Layering Principle
Hierarchy is achieved by "stacking" surface tiers. Place a `surface_container_lowest` card on a `surface_container_low` background. The subtle 2% difference in hex value creates a soft, natural lift.

### Ambient Shadows
If a floating element (like a modal) requires a shadow, it must be:
- **Blur:** 32px to 64px.
- **Opacity:** 4–6%.
- **Color:** Use a tint of `on_surface` (`#1a1c1c`) rather than pure black to keep the shadow feeling like a natural part of the environment.

### The "Ghost Border"
If a container requires a boundary for accessibility (e.g., an input field), use a **Ghost Border**: `outline_variant` (`#d1c5b4`) at 20% opacity. It should be felt, not seen.

---

## 5. Components

### Buttons
- **Primary:** Gradient fill (`primary` to `primary_container`), `on_primary` text. Use `ROUND_EIGHT` (0.5rem) corner radius.
- **Secondary:** Transparent background with a `primary` "Ghost Border" (20% opacity).
- **Tertiary:** Text-only, using `primary` color. In hover states, use a subtle `primary_fixed` background.

### Input Fields
- **Styling:** No solid bottom line. Use a `surface_container` fill with `ROUND_EIGHT` corners.
- **Focus State:** Transition the "Ghost Border" to a 1px `primary` border to signal active scholarly input.

### Cards & Lists
- **The Divider Ban:** Strictly forbid 1px divider lines. Separate list items using `8px` of vertical white space or alternating backgrounds between `surface` and `surface_container_low`.
- **Imagery:** Cards should feature images with a slight 5% `on_surface` overlay to ensure text readability if typography overlaps the image.

### Chips & Badges
- Used for academic tagging or categories. Use `secondary_container` with `on_secondary_container` text. Keep them pill-shaped (Round Full) to contrast against the `ROUND_EIGHT` of the primary containers.

---

## 6. Do's and Don'ts

### Do:
- **Do** embrace "The Breathing Room." Use double the standard spacing around `display` typography.
- **Do** use `tertiary` (`#a43a37`) sparingly for error states or "Academic Alerts." This red matches the rich tones found in the provided logo.
- **Do** ensure RTL layouts maintain the same "Editorial" feel, keeping the gold accent as the primary focal point on the leading edge of components.

### Don't:
- **Don't** use 100% black (`#000000`). Always use `on_background` (`#1a1c1c`) for a softer, premium ink-on-paper feel.
- **Don't** use heavy shadows. If you can clearly see the shadow, it is too dark.
- **Don't** use the `primary` gold for body text. It is for accents, CTAs, and headlines only. Body text must always be `on_surface` for maximum readability.
- **Don't** crowd the logo. The logo is a crest of authority; give it a "buffer zone" of at least 48px from any other UI element.