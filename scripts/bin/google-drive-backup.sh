#!/usr/bin/env bash
set -Eeuo pipefail

# -----------------------------
# Config
# -----------------------------
REMOTE_NAME="GoogleDrive"
BACKUP_ROOT="Backups"
MACHINE_NAME="$(uname -n)"
DATE_STAMP="$(date +%F)"
SNAPSHOT_NAME="${MACHINE_NAME}-${DATE_STAMP}"
REMOTE_BASE="${REMOTE_NAME}:${BACKUP_ROOT}/${MACHINE_NAME}"
REMOTE_SNAPSHOT_PATH="${REMOTE_BASE}/${SNAPSHOT_NAME}"

SOURCE_DIRS=(
  "$HOME/Documents"
  "$HOME/Pictures"
  "$HOME/Downloads"
)

LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}"
LOG_FILE="${LOG_DIR}/rclone-snapshot-backup.log"
LOCK_DIR="/tmp/rclone-snapshot-backup-${MACHINE_NAME}.lock"

RCLONE_FLAGS=(
  --fast-list
  --log-file "$LOG_FILE"
  --log-level INFO
)

# -----------------------------
# Optional args
# -----------------------------
DRY_RUN=0

for arg in "$@"; do
  case "$arg" in
    --dry-run)
      DRY_RUN=1
      ;;
    *)
      echo "Unknown argument: $arg" >&2
      echo "Usage: $0 [--dry-run]" >&2
      exit 1
      ;;
  esac
done

if [[ "$DRY_RUN" -eq 1 ]]; then
  RCLONE_FLAGS+=(--dry-run)
fi

# -----------------------------
# Helpers
# -----------------------------
timestamp() {
  date '+%Y-%m-%d %H:%M:%S'
}

log() {
  mkdir -p "$LOG_DIR"
  echo "[$(timestamp)] $*" | tee -a "$LOG_FILE"
}

cleanup() {
  rm -rf "$LOCK_DIR"
}
trap cleanup EXIT

# -----------------------------
# Pre-flight checks
# -----------------------------
if ! command -v rclone >/dev/null 2>&1; then
  echo "Error: rclone is not installed or not in PATH." >&2
  exit 1
fi

if ! mkdir "$LOCK_DIR" 2>/dev/null; then
  echo "Error: another backup appears to already be running." >&2
  exit 1
fi

mkdir -p "$LOG_DIR"

log "Starting backup"
log "Machine name: $MACHINE_NAME"
log "Remote snapshot path: $REMOTE_SNAPSHOT_PATH"

# Ensure the base snapshot folder exists
rclone mkdir "$REMOTE_SNAPSHOT_PATH" "${RCLONE_FLAGS[@]}"

# -----------------------------
# Backup each configured folder
# -----------------------------
for SRC in "${SOURCE_DIRS[@]}"; do
  if [[ ! -d "$SRC" ]]; then
    log "Skipping missing directory: $SRC"
    continue
  fi

  BASENAME="$(basename "$SRC")"
  DEST="${REMOTE_SNAPSHOT_PATH}/${BASENAME}"

  log "Copying $SRC -> $DEST"
  rclone copy "$SRC" "$DEST" "${RCLONE_FLAGS[@]}"
done

log "Backup complete"

