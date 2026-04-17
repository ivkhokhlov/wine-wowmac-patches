---
title: Launch
---

# Launch

Recommended patched fast-path command from the original validation setup:

```bash
WOW_FORCE_STOP=1 ~/wowmac/bin/stop-wow-client.sh
~/wowmac/bin/run-wow-client-smooth-fast-patched-minimal-debug.sh
```

Why this helper:

- keeps a small `+wgl` log,
- avoids huge `+seh/+opengl` traces,
- avoids framebuffer dump directories.
