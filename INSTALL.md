# Install From Zero

This document is the shortest end-to-end path from an empty checkout to a
patched `winemac.so`.

If you already have a configured Wine build tree, skip to [BUILD.md](BUILD.md).

## Prerequisites

- Apple Silicon macOS
- an existing local WoW/Wine setup, or your own equivalent launcher stack
- a writable local Wine source checkout
- a configured Wine build directory, or willingness to create one

This repository does not replace your WoW launcher stack. It publishes the
patches and helper files that made the fix reproducible.

## 1. Clone The Patch Repo

```bash
cd ~/code
git clone git@github.com:ivkhokhlov/wine-wowmac-patches.git
```

## 2. Clone Wine And Checkout The Tested Base

```bash
cd ~/code
git clone https://gitlab.winehq.org/wine/wine.git wine-wowmac
cd wine-wowmac
git checkout ada7c06102789033fec9ed9bc07e9a863afd8480
```

## 3. Apply The Patch Series

```bash
git am ~/code/wine-wowmac-patches/patches/*.patch
```

At this point your Wine tree should contain the `winemac.drv` changes from the
published fix series.

## 4. Create Or Reuse A Build Directory

If you already have a configured build directory for this Wine tree, reuse it.
That is the safest path.

Example minimal out-of-tree build directory:

```bash
cd ~/code
mkdir -p build-wowmac-x86_64
cd build-wowmac-x86_64
../wine-wowmac/configure --enable-win64
```

Adjust configure flags to match your own toolchain and existing stack.

## 5. Build The Patched Driver Module

```bash
make -C ~/code/build-wowmac-x86_64 -j"$(sysctl -n hw.ncpu)" \
  dlls/winemac.drv/winemac.so
```

If that succeeds, the patched module should be available under:

- `~/code/build-wowmac-x86_64/dlls/winemac.drv/winemac.so`

## 6. Wire Your Launcher To The Patched Build

Your launcher stack must point at the build directory that contains the patched
`winemac.so`.

The original local validation setup used:

- Wine tree: `~/code/wine-wowmac`
- build dir: `~/code/build-wowmac-x86_64`
- runtime helper:
  `~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh`

If your paths differ, adapt your launcher scripts accordingly.

## 7. Launch And Verify

Recommended runtime command from the original local setup:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

Then follow [docs/verify.md](docs/verify.md) or
[TROUBLESHOOTING.md](TROUBLESHOOTING.md) if the minimap still looks wrong.
