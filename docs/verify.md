---
title: Verify
---

# Verify

Use the same indoor location and the same minimap zoom for both checks.

## Patched OpenGL Path

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

## Slower Non-OpenGL Baseline

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
WOW_WINE_RUNTIME=stable WOW_GX_API=D3D9 WOW_D3D9_BACKEND=winerosetta \
  WOW_PROFILE=smooth ~/wowmac/bin/run-wow-client-60hz.sh
```

## Success Criteria

- indoor minimap is present instead of black or blank
- no moving colored stripe artifacts
- minimap shape and geometry broadly match the slower baseline
