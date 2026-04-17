# Manual GitHub Checklist For v0.1.0

These items are outside normal git push flow and must still be set in the
GitHub web UI.

## Repository About Section

Set:

- description:
  `Patch series and documentation for fixing WoW 3.3.5a indoor minimap on Apple Silicon macOS via winemac.drv while keeping the fast OpenGL path.`
- website:
  `https://ivkhokhlov.github.io/wine-wowmac-patches/`
- topics:
  `wine`, `winemac`, `macos`, `apple-silicon`, `world-of-warcraft`,
  `wow335a`, `opengl`, `wgl`, `pbuffer`, `cglcreatepbuffer`,
  `winerosetta`, `game-porting`

## GitHub Pages

Enable Pages from:

- branch: `main`
- folder: `/docs`

Expected URL:

- `https://ivkhokhlov.github.io/wine-wowmac-patches/`

## Social Preview

Upload:

- `docs/assets/social-preview.png`

## Discussions

Enable GitHub Discussions in repository settings.

## Pin The Repository

Pin `wine-wowmac-patches` on the GitHub profile after the repo looks final.

## GitHub Release

Create tag and release:

- tag: `v0.1.0`
- title: `v0.1.0`

Use:

- `releases/v0.1.0/RELEASE_NOTES.md`
- `releases/v0.1.0/SHA256SUMS.txt`

Recommended upload assets:

- `patches/0001-winemac-fall-back-to-offscreen-views-for-pbuffers.patch`
- `patches/0002-winemac-attach-detached-OpenGL-views-immediately.patch`
- `tools/run-wow-client-smooth-fast-patched-minimal-debug.sh`
- `docs/assets/social-preview.png`
- local before/after screenshots from validation runs
