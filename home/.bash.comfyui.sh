# ------------------------------------------------------------------------------
# ComfyUI Remote Helpers
# ------------------------------------------------------------------------------

comfyui_ssh() {
  echo "Opening ComfyUI SSH tunnel on 127.0.0.1:${REMOTE_LOCAL_PORT} -> ${REMOTE_SSH_HOST}:${REMOTE_WEB_PORT}"
  echo "You may be prompted for your SSH password."

  ssh -fN \
    -o ExitOnForwardFailure=yes \
    -o ServerAliveInterval=15 \
    -o ServerAliveCountMax=3 \
    -o ConnectTimeout=10 \
    -L "${REMOTE_LOCAL_PORT}:127.0.0.1:${REMOTE_WEB_PORT}" \
    -p "$REMOTE_SSH_PORT" \
    "$REMOTE_SSH_USER@$REMOTE_SSH_HOST"

  if [ $? -eq 0 ]; then
    echo "Tunnel established. Open http://127.0.0.1:${REMOTE_LOCAL_PORT}"
  else
    echo "Failed to establish tunnel."
    return 1
  fi
}

comfyui_ssh_stop() {
  local pid cmd matched_pids
  matched_pids=""

  for pid in $(lsof -tiTCP:"${REMOTE_LOCAL_PORT}" -sTCP:LISTEN 2>/dev/null); do
    cmd="$(ps -p "$pid" -o command= 2>/dev/null)"
    case "$cmd" in
      *"ssh"*"-L ${REMOTE_LOCAL_PORT}:127.0.0.1:${REMOTE_WEB_PORT}"*"-p ${REMOTE_SSH_PORT}"*"${REMOTE_SSH_USER}@${REMOTE_SSH_HOST}"*)
        matched_pids="${matched_pids} ${pid}"
        ;;
    esac
  done

  if [ -z "$matched_pids" ]; then
    echo "No matching ComfyUI SSH tunnel found on local port ${REMOTE_LOCAL_PORT}."
    return 0
  fi

  # shellcheck disable=SC2086
  kill $matched_pids
  echo "Stopped ComfyUI SSH tunnel:${matched_pids}"
}

comfyui_mount() {
  if ! command -v sshfs >/dev/null 2>&1; then
    echo "sshfs is not installed."
    return 1
  fi

  mkdir -p "$LOCAL_MOUNT_DIR"

  if command -v mountpoint >/dev/null 2>&1 && mountpoint -q "$LOCAL_MOUNT_DIR"; then
    echo "Already mounted at $LOCAL_MOUNT_DIR"
    return 0
  fi

  sshfs \
    -p "$REMOTE_SSH_PORT" \
    -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,follow_symlinks \
    "$REMOTE_SSH_USER@$REMOTE_SSH_HOST:$REMOTE_DIR" \
    "$LOCAL_MOUNT_DIR"

  if [ $? -eq 0 ]; then
    echo "Mounted: $REMOTE_DIR -> $LOCAL_MOUNT_DIR"
  else
    echo "Failed to mount: $REMOTE_DIR -> $LOCAL_MOUNT_DIR"
    return 1
  fi
}

comfyui_unmount() {
  if [ -z "${LOCAL_MOUNT_DIR:-}" ]; then
    echo "LOCAL_MOUNT_DIR is not set."
    return 1
  fi

  if command -v mountpoint >/dev/null 2>&1 && ! mountpoint -q "$LOCAL_MOUNT_DIR"; then
    echo "Not mounted: $LOCAL_MOUNT_DIR"
    return 0
  fi

  # Unmount fails if current working directory is inside the mount.
  case "$PWD" in
    "$LOCAL_MOUNT_DIR"|"$LOCAL_MOUNT_DIR"/*)
      echo "Current directory is inside mountpoint, changing to HOME first."
      cd "$HOME" || return 1
      ;;
  esac

  if command -v fusermount >/dev/null 2>&1; then
    if fusermount -u "$LOCAL_MOUNT_DIR"; then
      echo "Unmounted: $LOCAL_MOUNT_DIR"
      return 0
    fi
  else
    if umount "$LOCAL_MOUNT_DIR"; then
      echo "Unmounted: $LOCAL_MOUNT_DIR"
      return 0
    fi
  fi

  echo "Regular unmount failed (mount is busy)."
  if command -v fuser >/dev/null 2>&1; then
    echo "Processes using mountpoint:"
    fuser -vm "$LOCAL_MOUNT_DIR" 2>/dev/null || true
  elif command -v lsof >/dev/null 2>&1; then
    echo "Open files in mountpoint:"
    lsof +f -- "$LOCAL_MOUNT_DIR" 2>/dev/null || true
  fi

  echo "Trying lazy unmount..."
  if command -v fusermount >/dev/null 2>&1; then
    if fusermount -uz "$LOCAL_MOUNT_DIR"; then
      echo "Lazy unmounted: $LOCAL_MOUNT_DIR"
      return 0
    fi
  fi

  if umount -l "$LOCAL_MOUNT_DIR"; then
    echo "Lazy unmounted: $LOCAL_MOUNT_DIR"
    return 0
  fi

  echo "Failed to unmount: $LOCAL_MOUNT_DIR"
  return 1
}
