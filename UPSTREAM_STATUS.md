# Upstream Status

## Current State

- Public patch repository: active
- Clean patch series: published
- Tagged proof-of-fix release: planned in this repo
- Upstream Wine submission: not started
- External AppDB/wiki/forum write-up: not yet published

## Why This Repo Exists

The investigation and validation happened in a local Wine-based stack, but
direct push access to upstream Wine was not available.

Because of that, this repository acts as the first public staging area for:

- the clean patch series,
- validation notes,
- build and launch instructions,
- incoming reports from other Apple Silicon users.

## What Still Needs To Happen

1. Keep the current fix under wider real-world testing.
2. Collect reports from other Apple Silicon and macOS versions.
3. Reduce any remaining debug-only scaffolding if needed.
4. Decide whether the patch series is clean enough for an upstream attempt.

## Recommended Upstream Path

If the fix stays stable:

1. keep the current public repo as the user-facing reference;
2. prepare an upstream-focused patch series with tight technical justification;
3. submit the narrowest generic `winemac` changes, not the WoW-specific story as
   the main patch framing.
