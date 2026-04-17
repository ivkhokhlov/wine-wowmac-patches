---
title: Quickstart
---

# Quickstart

## 1. Clone The Repositories

```bash
cd ~/code
git clone https://gitlab.winehq.org/wine/wine.git wine-wowmac
git clone https://github.com/ivkhokhlov/wine-wowmac-patches.git
```

## 2. Checkout The Tested Wine Base

```bash
cd ~/code/wine-wowmac
git checkout ada7c06102789033fec9ed9bc07e9a863afd8480
```

## 3. Apply The Patch Series

```bash
git am ~/code/wine-wowmac-patches/patches/*.patch
```

## 4. Rebuild `winemac.so`

```bash
make -C ~/code/build-wowmac-x86_64 -j"$(sysctl -n hw.ncpu)" \
  dlls/winemac.drv/winemac.so
```

## 5. Launch The Patched Fast OpenGL Path

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

If your local layout differs, adapt the paths in your launcher stack.
