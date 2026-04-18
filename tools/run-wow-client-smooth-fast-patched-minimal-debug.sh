#!/bin/bash
set -euo pipefail

LOG_DIR="$HOME/wowmac/logs"
LOG_TO_FILE="${WOW_LOG_TO_FILE:-1}"
LOG_TO_CONSOLE="${WOW_LOG_TO_CONSOLE:-0}"
mkdir -p "$LOG_DIR"
STAMP="$(date +%Y%m%d-%H%M%S)"
LOG_FILE="$LOG_DIR/wow-opengl-patched-minimal-debug-$STAMP.log"
MINIMAL_WINEDEBUG="${WOW_MINIMAL_WINEDEBUG:-+timestamp,+pid,+tid,+wgl}"
WOW_MVK_LOG_LEVEL_VALUE="${WOW_MVK_LOG_LEVEL:-1}"

echo "Starting WoW smooth-fast-patched-minimal-debug. First window may appear in 20-30 seconds."
echo "Using lightweight WINEDEBUG filter: $MINIMAL_WINEDEBUG"
echo "Using MoltenVK log level: $WOW_MVK_LOG_LEVEL_VALUE"
if [[ "$LOG_TO_FILE" == "1" ]]; then
  echo "Wine log: $LOG_FILE"
else
  echo "Wine log disabled (WOW_LOG_TO_FILE=$LOG_TO_FILE)"
fi
if [[ "$LOG_TO_CONSOLE" == "1" ]]; then
  echo "Console mirroring enabled (WOW_LOG_TO_CONSOLE=$LOG_TO_CONSOLE)"
else
  echo "Console mirroring disabled; runtime spam stays out of the terminal"
fi

if [[ "$LOG_TO_FILE" == "1" && "$LOG_TO_CONSOLE" == "1" ]]; then
  exec env \
    WOW_WINEDEBUG="$MINIMAL_WINEDEBUG" \
    WOW_MVK_LOG_LEVEL="$WOW_MVK_LOG_LEVEL_VALUE" \
    WOW_PBUFFER_DUMP_DIR= \
    "$HOME/wowmac/bin/run-wow-client-smooth-fast-patched.sh" "$@" \
    2>&1 | tee "$LOG_FILE"
elif [[ "$LOG_TO_FILE" == "1" ]]; then
  exec env \
    WOW_WINEDEBUG="$MINIMAL_WINEDEBUG" \
    WOW_MVK_LOG_LEVEL="$WOW_MVK_LOG_LEVEL_VALUE" \
    WOW_PBUFFER_DUMP_DIR= \
    "$HOME/wowmac/bin/run-wow-client-smooth-fast-patched.sh" "$@" \
    >"$LOG_FILE" 2>&1
elif [[ "$LOG_TO_CONSOLE" == "1" ]]; then
  exec env \
    WOW_WINEDEBUG="$MINIMAL_WINEDEBUG" \
    WOW_MVK_LOG_LEVEL="$WOW_MVK_LOG_LEVEL_VALUE" \
    WOW_PBUFFER_DUMP_DIR= \
    "$HOME/wowmac/bin/run-wow-client-smooth-fast-patched.sh" "$@"
else
  exec env \
    WOW_WINEDEBUG="$MINIMAL_WINEDEBUG" \
    WOW_MVK_LOG_LEVEL="$WOW_MVK_LOG_LEVEL_VALUE" \
    WOW_PBUFFER_DUMP_DIR= \
    "$HOME/wowmac/bin/run-wow-client-smooth-fast-patched.sh" "$@" \
    >/dev/null 2>&1
fi
