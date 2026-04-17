# Troubleshooting

## Indoor Minimap Is Still Black Or Blank

Check the following first:

1. Make sure your launcher is loading the patched Wine build, not an older
   system build.
2. Rebuild `dlls/winemac.drv/winemac.so` after applying the patch series.
3. Use the lightweight helper from this repo before moving to the heavy debug
   launcher.

Recommended command:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

## Full Screen Turns White Indoors

That behavior was caused by an earlier failed experiment that forced
`glDrawBuffer()` / `glReadBuffer()` on the emulated pbuffer path.

The clean published patch series does not contain that experiment. If you still
see the white-screen failure, verify that you are running the clean published
patches and not an older local checkpoint branch.

## Colored Stripes Still Appear

If you still get moving horizontal bands or small colored blocks instead of a
real minimap:

1. confirm that `0002-winemac-attach-detached-OpenGL-views-immediately.patch`
   is actually applied;
2. confirm that the rebuilt `winemac.so` is the one your launcher uses;
3. compare against the slower non-OpenGL baseline to separate rendering bugs
   from map-data issues.

## Compare Against The Non-OpenGL Baseline

Use the same indoor location and the same minimap zoom level.

Patched OpenGL path:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

Stable non-OpenGL baseline:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
WOW_WINE_RUNTIME=stable WOW_GX_API=D3D9 WOW_D3D9_BACKEND=winerosetta \
  WOW_PROFILE=smooth ~/wowmac/bin/run-wow-client-60hz.sh
```

## Minimal Debug vs Full Debug

Use the minimal helper first:

- `tools/run-wow-client-smooth-fast-patched-minimal-debug.sh`

It keeps only a small `+wgl` log and avoids framebuffer dump spam.

Only switch to the heavy debug launcher if you need:

- `+seh/+opengl` tracing,
- framebuffer dump directories,
- deeper source-level investigation.

## Logs

The original local stack wrote logs under:

- `~/wowmac/logs`

Minimal helper log format:

- `wow-opengl-patched-minimal-debug-YYYYMMDD-HHMMSS.log`

## Slow Launch Or Stale Wine Processes

Before each retest:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
```

If launch timing looks wrong, stop the stack, wait for `wineserver` to exit, and
restart from the minimal helper.
