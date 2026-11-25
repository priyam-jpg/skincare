---
name: Your Brand (White Studio)
description: Korean skincare storefront on a pure white field; black ink and black actions, hairline rules, a photo that dissolves into the page, Hangul captions as the only green.
colors:
  ground: "#ffffff"
  band: "#f4f4f2"
  paper: "#ffffff"
  ink: "#111111"
  ink-2: "#595959"
  line: "rgba(17, 17, 17, 0.14)"
  green: "#3f5f3a"
  red: "#a3362b"
typography:
  display:
    fontFamily: "Google Sans, system-ui, sans-serif"
    fontSize: "4.5rem"
    fontWeight: 600
    lineHeight: 1.02
    letterSpacing: "-0.035em"
  headline:
    fontFamily: "Google Sans, system-ui, sans-serif"
    fontSize: "2.75rem"
    fontWeight: 600
    lineHeight: 1.1
    letterSpacing: "-0.02em"
  title:
    fontFamily: "Google Sans, system-ui, sans-serif"
    fontSize: "1.375rem"
    fontWeight: 600
    lineHeight: 1.25
    letterSpacing: "-0.02em"
  body:
    fontFamily: "Google Sans, system-ui, sans-serif"
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.65
  label:
    fontFamily: "Google Sans, system-ui, sans-serif"
    fontSize: "0.9375rem"
    fontWeight: 600
    lineHeight: 1
  hangul:
    fontFamily: "Noto Sans KR, Apple SD Gothic Neo, Malgun Gothic, sans-serif"
    fontSize: "2.5rem"
    fontWeight: 500
    lineHeight: 1
rounded:
  md: "10px"
  lg: "14px"
  tag: "3px"
spacing:
  gutter: "clamp(20px, 5vw, 72px)"
  section: "clamp(56px, 7vw, 104px)"
  max-width: "1320px"
components:
  button-primary:
    backgroundColor: "{colors.ink}"
    textColor: "{colors.paper}"
    rounded: "{rounded.md}"
    padding: "0 24px"
    height: "48px"
  button-primary-hover:
    backgroundColor: "#3a3a3a"
  button-ghost:
    backgroundColor: "transparent"
    textColor: "{colors.ink}"
    rounded: "{rounded.md}"
    padding: "0 24px"
    height: "48px"
  tag-sale:
    backgroundColor: "{colors.red}"
    textColor: "{colors.paper}"
    rounded: "{rounded.tag}"
    padding: "4px 9px"
  product-card:
    backgroundColor: "{colors.paper}"
    rounded: "{rounded.lg}"
    padding: "22px 24px 26px"
---

# Design System: Your Brand (White Studio)

## Overview

**Creative North Star: "The White Studio"**

The page is one white field. The announcement bar is black, then the header sits transparent over a white hero whose studio photograph fades at its top and left edges, so header, headline and faces share a single surface. Below, the page alternates white and a barely-grey band (#f4f4f2), separated by hairlines, and ends in a black footer. Colour comes from photography and product art, not from the interface.

Density is generous and calm: wide section padding, thin rules, tight negative-tracked Google Sans at weight 600 for every heading. Actions are black. Red and green are rationed to single jobs so they stay legible as signals.

**Key Characteristics:**
- White ground, near-black ink, grey secondary text; black bars top and bottom.
- Transparent header that turns solid white with a hairline once scrolled.
- Photo dissolved into the page by mask, never boxed under a nav bar.
- Soft neutral shadows on cards only; everything else is flat with hairlines.
- Numbered routine with a strict margin column as the page's ordered device.

## Colors

A white-and-black palette with two single-purpose signal colours.

### Primary
- **Studio Black** (#111111, `--ink`): body text, headings, primary buttons, announcement bar, footer ground, selection, star ratings.

### Secondary
- **Sale Red** (#a3362b, `--red`): Sale/New/Bestseller tags, the bag-count badge, and the small dot in the logo mark. Nothing else.
- **Hangul Green** (#3f5f3a, `--green`): Hangul captions (routine step gloss, ingredient labels), the focus ring, and the ghost-button hover border.

### Neutral
- **Pure White** (#ffffff, `--ground` / `--paper`): page, cards, header when solid.
- **Gallery Band** (#f4f4f2, `--band`): alternating section bands, product-art grounds, lead review, hover fills.
- **Quiet Grey** (#595959, `--ink-2`): secondary copy, meta lines.
- **Hairline** (rgba(17,17,17,0.14), `--line`): borders, dividers, trust strip rules.

### Named Rules
**The Rationed Signal Rule.** Red is only for sale tags and the bag count; green is only for Hangul captions (plus focus affordances). If a new element wants colour, it takes ink or grey.

**The Black Action Rule.** Primary buttons are black on white and white on the black footer. No coloured CTA.

## Typography

**Display / Body Font:** Google Sans (with system-ui, sans-serif)
**Hangul Font:** Noto Sans KR (weights 400, 500; Google Sans has no Hangul glyphs)

**Character:** One sans family doing all the work through weight and tracking: confident 600-weight headlines pulled tight, quiet 400 body in grey.

### Hierarchy
- **Display** (600, clamp(2.5rem, 1.3rem + 4vw, 4.5rem), 1.02, -0.035em): hero headline only, max 12ch.
- **Headline** (600, clamp(1.75rem, 1.2rem + 2.2vw, 2.75rem), 1.1, -0.02em): section titles, max 22ch, balanced.
- **Title** (600, 1rem to 1.5rem, 1.25): product, step (1.375rem) and set (1.5rem) names.
- **Body** (400, 1rem, 1.65): paragraphs; intros capped at 44-52ch, in grey.
- **Label** (600, 0.9375rem): buttons; tags are 0.75rem, uppercase, +0.04em.
- **Hangul caption** (500, 0.9375rem inline, 2.5rem on ingredient labels, green): glosses only.

### Named Rules
**The Tabular Price Rule.** Prices and counts use tabular lining numerals at weight 600.

## Layout

Single column on phones, content max 1320px, side gutter clamp(20px, 5vw, 72px), section padding clamp(56px, 7vw, 104px). Breakpoints in use: 560 (set cards split), 700 (hero becomes side-by-side, 3-up carousel), 800, 900 (desktop header with centred logo, nav left, tools right), 1000 (routine 4/8 split with sticky intro, 3-col labels), 1100 (4-up carousel, 6-up trust strip). The hero is a flex field with min-height clamp(640px, 100svh - 40px, 880px); the photo is anchored bottom-right at 62% width; on phones copy leads and the photo follows, fading upward. The header overlaps the hero via a negative bottom margin (78px). Routine steps use a fixed numeral column (88px desktop, 56px mobile).

## Elevation & Depth

Mostly flat: hairlines and the grey band carry separation. Cards and sets rest on one soft neutral shadow and lift 3px on hover.

### Shadow Vocabulary
- **Card rest** (`box-shadow: 0 1px 2px rgba(17,17,17,0.1), 0 2px 8px -2px rgba(17,17,17,0.08)`): product cards, set cards.
- **Card hover** (`0 14px 22px -14px rgba(17,17,17,0.38)` over card rest): product card hover.

### Named Rules
**The Hairline First Rule.** Separate with a 1px hairline or a band change before reaching for a shadow; shadows belong to cards.

## Shapes

Softly rounded: 10px on buttons, inputs and inset product rows, 14px on cards, sets, labels and story image, 3px on tags, full pill on the bag badge. Dividers are 1px; the routine list opens with a 1px solid ink rule. Media is clipped by its container radius; the hero photo is the exception, shaped by gradient mask instead of a frame.

## Components

### Buttons
- **Shape:** 10px radius, 48px min height, 24px horizontal padding, 600 weight.
- **Primary:** black (#111111) with white text; hover lightens to #3a3a3a. In the footer it inverts to white on black.
- **Ghost:** transparent, 1px ink-at-30% border; hover fills with the band grey and turns the border green.
- **Hover / Focus:** 180ms ease-out colour change, 1px press on active; focus ring 2px green, 3px offset (white on the footer).

### Header
Transparent over the hero, 78px tall, grid of nav / logo / tools. Gains a solid white ground and hairline bottom border when `data-solid="true"` (scrolled). Nav links underline by a left-to-right 1.5px ink sweep on hover. Mobile nav drops as a white panel with hairline-separated rows.

### Cards / Containers
- **Product card:** white, 1px hairline, 14px radius, square art area on neutral band grey, name 600, meta in grey, price and add action on one row; red tag top-left of the art.
- **Set card:** same shell, art band on the left half from 560px.
- **Ingredient labels:** hairline-gridded cells (1px gap over the line colour), Hangul in green at 2.5rem above the English name.
- **Review:** hairline card; the lead review sits on the band at larger type.

### Trust strip
White with hairline top and bottom, icons and 0.875rem labels in ink, 2/3/6 columns by width.

### Inputs / Fields
Newsletter field on the black footer: white fill, 10px radius, 48px high, placeholder #767676.

### Routine step (signature)
Large tabular numeral in a fixed margin column, title with an inline green Hangul gloss, grey description, and an inset product row with band-grey thumbnail. Rows divided by hairlines under a 1px ink top rule.

## Do's and Don'ts

### Do:
- **Do** keep the ground #ffffff and use #f4f4f2 only for alternating bands and product-art grounds.
- **Do** make every primary action black with white text.
- **Do** let photography dissolve into the white page with a mask rather than a frame.
- **Do** separate with 1px hairlines (`--line`) first.
- **Do** keep Hangul captions in Noto Sans KR, green.

### Don't:
- **Don't** use red anywhere except sale/new/bestseller tags and the bag count.
- **Don't** use green for anything beyond Hangul captions and focus/hover affordances.
- **Don't** reintroduce warm tan, brown, wood-grain or brass surfaces; the earlier drawer-wall world is retired.
- **Don't** box the hero photo beneath a solid nav bar.
- **Don't** add heavy or tinted shadows; shadows stay neutral and soft.
