---
title: Overview
---

# wine-wowmac-patches

This site is the canonical guide for the published `winemac.drv` patch series
that restores the **World of Warcraft 3.3.5a indoor minimap** on
**Apple Silicon macOS** while keeping the fast OpenGL path.

## What It Fixes

- black or blank indoor minimap on the fast OpenGL path
- colored stripe artifacts inside the minimap
- offscreen rendering breakage after `CGLCreatePBuffer()` failure

## Who This Is For

Use this if:

- you already have a Wine-based WoW stack on Apple Silicon macOS,
- your fast OpenGL path has the indoor minimap bug,
- you want a narrow `winemac.drv` fix instead of abandoning the fast path.

## Read Next

- [Quickstart](quickstart)
- [Build](build)
- [Launch](launch)
- [Verify](verify)
- [Troubleshooting](troubleshooting)
- [Technical Notes](technical)
- [FAQ](faq)
