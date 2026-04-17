---
title: Troubleshooting
---

# Troubleshooting

## Minimap Still Black

- confirm the published patch series is applied
- rebuild `dlls/winemac.drv/winemac.so`
- confirm your launcher points at the patched Wine build

## White Screen Indoors

The published clean series does not include the older experimental draw/read
buffer forcing that caused full-screen whiteout. Verify that you are not using
an older local checkpoint build.

## Need More Detail

Start with the minimal helper. Only switch to the heavy debug launcher when you
actually need framebuffer dumps or full `+opengl` tracing.
