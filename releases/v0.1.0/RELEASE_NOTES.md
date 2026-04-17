# v0.1.0

First public proof-of-fix release for the published `winemac.drv` patch series.

## What It Fixes

- restores the WoW 3.3.5a indoor minimap on the fast OpenGL path
- avoids giving up immediately to the slower non-OpenGL baseline
- keeps the fix local to `winemac.drv`

## Published Contents

- clean two-patch series under `patches/`
- lightweight runtime helper under `tools/`
- build, install, troubleshooting, and technical notes
- GitHub Pages-ready canonical guide under `docs/`

## Validation Base

- Wine base commit:
  `ada7c06102789033fec9ed9bc07e9a863afd8480`
- exported clean branch tip:
  `96d29072f469398240a18a6520a615ce8d1c4b82`

## Validation Environment

- Mac model: `MacBookPro18,1`
- SoC: `Apple M1 Pro`
- Memory: `32 GB`
- macOS: `26.3.1 (25D771280a)`
- Game: `World of Warcraft 3.3.5a (build 12340)`

## Notes

- This release is a patch/documentation release, not a full Wine binary build.
- The intended application path is `git am` onto the tested Wine base commit.
