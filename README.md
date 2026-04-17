# wine-wowmac-patches

Clean `winemac.drv` patch series and runtime notes for restoring the indoor
minimap on the fast OpenGL path for **World of Warcraft 3.3.5a (build 12340)**
on **Apple Silicon macOS**.

## Status

This patch series was validated against a local Wine tree where the original
fast OpenGL path showed the classic indoor minimap failure:

- blank or black indoor minimap,
- moving colored stripe artifacts,
- broken offscreen rendering after `CGLCreatePBuffer()` failed.

With the two patches in this repository applied, the minimap recovered and the
result matched the slower non-OpenGL baseline closely enough for practical use.

## What this contains

This repository is not a full Wine fork. It is a small artifact repository that
stores:

- a clean two-patch `winemac` series,
- a lightweight launcher script used during validation,
- enough context to understand what the patches are for.

The clean patch series does two things:

1. Falls back to an offscreen `NSView` when `CGLCreatePBuffer()` fails.
2. Attaches detached offscreen OpenGL views immediately instead of deferring
   them through the normal latent-view path.

In the tested local setup, this was enough to recover indoor minimap rendering
while keeping the fast OpenGL path usable.

## Patch series

The patches are stored under [`patches/`](patches):

- `0001-winemac-fall-back-to-offscreen-views-for-pbuffers.patch`
- `0002-winemac-attach-detached-OpenGL-views-immediately.patch`

The clean local branch tip used for export was:

- `96d2907` `winemac: attach detached OpenGL views immediately`

The original local safety checkpoint with extra investigation code was kept
separately and is intentionally not published here as the main patch set.

## Repository layout

- `README.md` - overview, rationale, and apply instructions
- `patches/` - clean two-patch `git am` series
- `tools/` - lightweight runtime helper used during validation

## Runtime helper

A lightweight launcher is stored under [`tools/`](tools):

- `run-wow-client-smooth-fast-patched-minimal-debug.sh`

It keeps a small `+wgl` log but avoids the huge trace volume and framebuffer
dump spam used during the deeper debugging phase.

Recommended runtime command in the original local setup:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

## Applying the patches

These patches were exported from a local Wine tree based on:

- `ada7c06` `winemac: Relax builtin __atomic memory barriers.`

Example flow:

```bash
git clone https://gitlab.winehq.org/wine/wine.git wine-wowmac
cd wine-wowmac
git checkout ada7c06
git am /path/to/wine-wowmac-patches/patches/*.patch
```

## Notes

- The motivating reproducible case here was WoW 3.3.5a indoor minimap rendering
  on Apple Silicon macOS.
- The fix is published as a generic `winemac` patch series, not as a game-only
  hack.
- This repository exists because direct contribution access to the upstream Wine
  repository was not available in the tested environment.
