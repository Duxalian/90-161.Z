# Color sources for 90-161.Z (12 Nov 26)

Question (PFM): wings use Air Force blue, yellow and sometimes orange accents; where do color rules come from? Self-review by Claude; the .mil sources below could not be opened from the cloud (network blocked), so numbers are unconfirmed until the PFM saves them (go.md Task 12).

## What AFI 84-105 (1 Apr 2025) says, read in full

| Para | Rule | Applies to |
|---|---|---|
| 3.7.5.1 | No metallic colors, highlights, dilution, shading, gradual blending or other special effects | Unit emblems |
| 3.7.5.2 | At most 6 colors; black and white count | Unit emblems |
| 3.7.5.3 | Use the official AF colors: ultramarine blue/reflex blue and AF yellow | Unit emblems |
| 3.7.5.4-5 | Establishments: AF yellow shield border; scroll white field, AF yellow edge, ultramarine blue letters | Establishment emblems |
| 3.7.5.6 | Unit scroll: any color if 6 or fewer colors total; border not white; border = letter color; one light and one dark color for contrast | Unit scrolls |
| 3.7.6 | The Institute of Heraldry (TIOH) sets exact colors, sizes, manufacture | Emblem artwork |
| 3.7.10 | Background: Guide to Air Force Heraldry (June 2022) | Emblems |
| Terms | AF yellow = excellence; ultramarine (reflex) blue = the sky | - |

AFI 84-105 names the colors but gives no numbers. It governs emblems, flags and patches, not briefings, documents or apps. Orange has no AF meaning; it may appear only inside a unit's own approved emblem (6-color limit).

## Numeric values found (unconfirmed)

| Color | Value | Source | Confidence |
|---|---|---|---|
| AF yellow | PMS 116; RGB 255/213/32 (#FFD520); CMYK 0/15/94/0 | Archived AF Trademark Program color page, 2013 (search summary only) | Medium-low |
| Ultramarine blue (reflex) | PMS Reflex Blue; RGB 0/83/159 (#00539F); CMYK 100/72/0/6 | Same archived page | Medium-low |
| Pantone Reflex Blue | #001489 | Third-party heraldry reference | Low |
| Ultramarine blue (cloth) | Cable 65010; AF yellow cable 80068 | Third-party flag site | Low |

## Sources to obtain (go.md Task 12)

1. ANG Graphics Standard (Air National Guard public website): the ANG's own colors and layout rules; most likely to govern ANG briefings and products.
2. Air Force Symbol page (Air Force Trademark and Licensing website, Branding): current official Pantone, CMYK and RGB for the AF blue and yellow.
3. Guide to Air Force Heraldry, June 2022 (DAF History website): the color section behind AFI 84-105 3.7.10.
The Tongue and Quill (AFH 33-337, 2015) was searched, not read in full: no color rule for slides found (confidence medium).

## Contrast of candidate colors (WCAG 2.1; measured)

| Pair | Ratio | AA use |
|---|---|---|
| #00539F blue on white | 7.67:1 | Any text |
| #FFD520 yellow on white | 1.42:1 | Never text or lines on white |
| #FFD520 yellow on #00539F blue | 5.40:1 | Any text |
| Dark text #1B1F2A on #FFD520 yellow | 11.59:1 | Any text |
| #E35205 orange on white | 3.84:1 | Large text and UI parts only |
| #B84400 dark orange on white | 5.43:1 | Any text |

**Rec:** one palette file in the repo drives the decks and the app theme: AF blue as the dominant color, AF yellow only as a fill or on blue (never on white), one dark orange accent for warnings, plus the red, amber and green status colors already measured. Numbers wait for sources 1-2.
