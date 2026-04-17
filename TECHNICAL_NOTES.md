# Technical Notes

## Confirmed During Investigation

- The bug was tied to the fast OpenGL renderer path, not to server state,
  addons, account state, or generic WoW data corruption.
- The slower non-OpenGL profiles rendered the indoor minimap correctly.
- `CGLCreatePBuffer()` failed on the relevant path inside `winemac.drv`.
- A local fallback to an emulated offscreen drawable removed or reduced the old
  screen jerk/flicker when entering indoor areas.
- The minimap still remained broken after the first fallback.
- Debug dumps later showed that texture-copy uploads were not empty, but often
  collapsed into narrow horizontal bands inside the expected `256x256` region.

## Working Root Cause

The final fix path suggests that the real problem was not the texture copy call
itself, but the drawable semantics behind the emulated pbuffer fallback.

More specifically:

- once `CGLCreatePBuffer()` failed, Wine fell back to an offscreen view;
- that detached offscreen view could still pass through a delayed `latentView`
  attach path;
- WoW then rendered into the wrong effective drawable state;
- later `glCopyTexImage2D()` / `glCopyTexSubImage2D()` operations copied from a
  source that was only partially valid, which explained the stripe-like dumps.

The second patch fixes this by attaching detached offscreen views immediately.

## Files Changed

### `dlls/winemac.drv/opengl.c`

This patch series adds:

- fallback handling when `CGLCreatePBuffer()` fails,
- emulated offscreen drawable state,
- a local emulated texture-copy path suitable for the fallback,
- viewport/scissor save-and-restore around the emulated pbuffer path.

### `dlls/winemac.drv/cocoa_opengl.m`

This patch series also changes offscreen view attachment behavior so detached
views are attached immediately instead of waiting for the normal latent-view
path.

That narrow change was the decisive step that turned striped/black minimap
frames into a working indoor minimap.

## What Was Explicitly Rejected

The investigation also tried broader approaches that were intentionally not
published here as the main fix:

- global `opengl32` interception,
- broad `GL_FRONT`/`GL_BACK` forcing,
- invasive `glCopyTexImage2D` internal-format rewrites.

Those approaches were either too invasive, broke startup, or caused full-screen
rendering regressions.

## Practical Conclusion

The published series aims to stay local to `winemac.drv` and fix the offscreen
rendering path rather than papering over the symptom globally.
