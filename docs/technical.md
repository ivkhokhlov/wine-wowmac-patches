---
title: Technical Notes
---

# Technical Notes

The working conclusion from the original debugging session:

- `CGLCreatePBuffer()` failed on the affected path inside `winemac.drv`;
- Wine fell back to an emulated offscreen drawable;
- detached offscreen views could still take the delayed `latentView` attach
  path;
- WoW then rendered into the wrong effective drawable state;
- later texture-copy operations produced partial stripe-like uploads instead of
  a full minimap image.

The decisive fix was to attach detached offscreen views immediately.
