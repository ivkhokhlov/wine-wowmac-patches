# wine-wowmac-patches

Patch series, docs, and release-prep assets for fixing the **World of
Warcraft 3.3.5a indoor minimap** on **Apple Silicon macOS** through a narrow
`winemac.drv` fix while keeping the fast OpenGL path.

## Status

This repository is a public artifact repo, not a full Wine fork.

The published patch series was validated against a local Wine tree where the
unpatched fast OpenGL path showed the classic indoor minimap failure:

- blank or black indoor minimap indoors,
- moving colored stripe artifacts,
- offscreen rendering breakage after `CGLCreatePBuffer()` failure.

With the two clean patches from this repo applied, the minimap recovered and
matched the slower non-OpenGL baseline closely enough for practical use.

## Quick Links

- [INSTALL.md](INSTALL.md) - from-zero setup flow
- [BUILD.md](BUILD.md) - patch apply and build instructions
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - known failure modes and checks
- [TECHNICAL_NOTES.md](TECHNICAL_NOTES.md) - root cause and patch notes
- [UPSTREAM_STATUS.md](UPSTREAM_STATUS.md) - publication and upstream status
- [docs/](docs/) - GitHub Pages-ready canonical guide
- [releases/v0.1.0/RELEASE_NOTES.md](releases/v0.1.0/RELEASE_NOTES.md) - first
  tagged release notes
- [releases/v0.1.0/UPLOAD_CHECKLIST.md](releases/v0.1.0/UPLOAD_CHECKLIST.md) -
  manual GitHub Release and repo-settings checklist

## Patch Series

The clean series is under [`patches/`](patches):

- `0001-winemac-fall-back-to-offscreen-views-for-pbuffers.patch`
- `0002-winemac-attach-detached-OpenGL-views-immediately.patch`

The exported clean branch tip was:

- `96d2907` `winemac: attach detached OpenGL views immediately`

The Wine base commit used during validation was:

- `ada7c06102789033fec9ed9bc07e9a863afd8480`
  `winemac: Relax builtin __atomic memory barriers.`

## Runtime Helper

A lightweight launcher helper is published under [`tools/`](tools):

- `run-wow-client-smooth-fast-patched-minimal-debug.sh`

Recommended runtime command in the original local setup:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

This keeps a small `+wgl` log but avoids the huge trace volume and framebuffer
dump spam from the heavier debug launcher.
By default it writes runtime output to the log file without mirroring the full
stream back to the terminal. Set `WOW_LOG_TO_CONSOLE=1` if you explicitly want
console mirroring while testing.

## Repository Layout

- `README.md` - overview and entry points
- `INSTALL.md` - end-to-end setup from a clean checkout
- `BUILD.md` - apply/build/rebuild commands
- `TROUBLESHOOTING.md` - symptom-driven checks
- `TECHNICAL_NOTES.md` - investigation summary and root cause
- `UPSTREAM_STATUS.md` - where publication currently stands
- `patches/` - clean `git am` patch series
- `tools/` - helper scripts
- `docs/` - Pages-ready canonical install guide
- `releases/` - release notes and checksum manifests
- `.github/ISSUE_TEMPLATE/` - issue forms for incoming reports

## Validation Environment

The proof-of-fix used the following local environment:

- Mac model: `MacBookPro18,1`
- SoC: `Apple M1 Pro`
- Memory: `32 GB`
- macOS: `26.3.1 (25D771280a)`
- Game: `World of Warcraft 3.3.5a (build 12340)`

## Applying the Patches

Example flow:

```bash
git clone https://gitlab.winehq.org/wine/wine.git wine-wowmac
git clone https://github.com/ivkhokhlov/wine-wowmac-patches.git
cd wine-wowmac
git checkout ada7c06102789033fec9ed9bc07e9a863afd8480
git am ../wine-wowmac-patches/patches/*.patch
```

Then follow [BUILD.md](BUILD.md) for the module rebuild step.

## GitHub Pages

The repository contains a GitHub Pages-ready guide under [`docs/`](docs/).
Once Pages is enabled in repository settings, the expected project-site URL is:

- `https://ivkhokhlov.github.io/wine-wowmac-patches/`

## Social Preview Asset

A ready-made preview image is included at:

- [`docs/assets/social-preview.png`](docs/assets/social-preview.png)

This still has to be uploaded once in the GitHub repository settings because the
social preview setting itself is not driven by git history.

## License

This repository is published under `LGPL-2.1-or-later`. See [LICENSE](LICENSE).

## Notes

- The motivating reproducible case here was WoW 3.3.5a indoor minimap rendering
  on Apple Silicon macOS.
- The fix is published as a generic `winemac` patch series, not as a game-only
  `opengl32` interception hack.
- This repository exists because direct contribution access to upstream Wine was
  not available in the validation environment.
