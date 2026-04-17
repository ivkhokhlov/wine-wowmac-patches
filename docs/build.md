---
title: Build
---

# Build

The fastest validation loop is usually a module-only rebuild:

```bash
make -C ~/code/build-wowmac-x86_64 -j"$(sysctl -n hw.ncpu)" \
  dlls/winemac.drv/winemac.so
```

If you need a fresh build directory:

```bash
cd ~/code
mkdir -p build-wowmac-x86_64
cd build-wowmac-x86_64
../wine-wowmac/configure --enable-win64
make -j"$(sysctl -n hw.ncpu)" dlls/winemac.drv/winemac.so
```

Adjust configure flags for your own stack.
