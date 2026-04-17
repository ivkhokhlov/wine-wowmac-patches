---
title: FAQ
---

# FAQ

## Is This A Full Wine Fork?

No. This repo publishes a clean patch series, docs, and helper assets.

## Does It Replace My Existing Launcher Stack?

No. You still need your own Wine/WoW runtime layout. This repo shows what to
patch and how to validate it.

## Why Not Use A Slower D3D Path Instead?

Because the goal here was to keep the high-FPS fast OpenGL path and fix the
driver-side offscreen rendering issue locally in `winemac.drv`.

## Is This Upstream In Wine?

Not yet. See [../UPSTREAM_STATUS.md](../UPSTREAM_STATUS.md).
