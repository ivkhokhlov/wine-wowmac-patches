# Build Notes

This repository publishes a narrow `winemac.drv` patch series. In practice, the
fastest validation loop is usually a module-only rebuild of `winemac.so`.

## Apply The Patches

```bash
cd ~/code/wine-wowmac
git checkout ada7c06102789033fec9ed9bc07e9a863afd8480
git am ~/code/wine-wowmac-patches/patches/*.patch
```

## Incremental Rebuild

If your Wine tree is already configured, rebuild only the patched module:

```bash
make -C ~/code/build-wowmac-x86_64 -j"$(sysctl -n hw.ncpu)" \
  dlls/winemac.drv/winemac.so
```

This is the recommended iteration command while testing the minimap fix.

## Clean Build Directory Example

If you need a new build directory:

```bash
cd ~/code
mkdir -p build-wowmac-x86_64
cd build-wowmac-x86_64
../wine-wowmac/configure --enable-win64
make -j"$(sysctl -n hw.ncpu)" dlls/winemac.drv/winemac.so
```

Adjust configure flags to match your local Wine setup.

## When Full-Tree Builds Fail

During investigation it was common for full-tree builds to fail on unrelated
generated dependencies while the `winemac.drv` module itself still rebuilt
correctly.

If your tree is already configured, prefer the module-only command first:

```bash
make -C ~/code/build-wowmac-x86_64 -j"$(sysctl -n hw.ncpu)" \
  dlls/winemac.drv/winemac.so
```

## What To Expect

Successful output should refresh:

- `~/code/build-wowmac-x86_64/dlls/winemac.drv/winemac.so`

Your launcher must load Wine from the build directory that contains this file.

## Runtime Helper

The repo includes a lightweight helper:

- [`tools/run-wow-client-smooth-fast-patched-minimal-debug.sh`](tools/run-wow-client-smooth-fast-patched-minimal-debug.sh)

That helper is not tied to one exact path layout, but the original local stack
expected the patched build under `~/code/build-wowmac-x86_64`.
