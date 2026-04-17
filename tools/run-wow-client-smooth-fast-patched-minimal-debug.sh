#!/bin/bash
set -euo pipefail

LOG_DIR="$HOME/wowmac/logs"
mkdir -p "$LOG_DIR"
STAMP="$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$LOG_DIR/wow-opengl-patched-minimal-debug-$STAMP.log"
MINIMAL_WINEDEBUG="${WOW_MINIMAL_WINEDEBUG:-+timestamp,+pid,+tid,+wgl}"

echo "Starting WoW smooth-fast-patched-minimal-debug. First window may appear in 20-30 seconds."
echo "Wine log: $LOG_FILE"
echo "Using lightweight WINEDEBUG filter: $MINIMAL_WINEDEBUG"

exec env \
  WOW_WINEDEBUG="$MINIMAL_WINEDEBUG" \
  WOW_PBUFFER_DUMP_DIR= \
  "$HOME/wowmac/bin/run-wow-client-smooth-fast-patched.sh" "$@" \
  2>&1 | tee "$LOG_FILE"
