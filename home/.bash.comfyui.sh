# ------------------------------------------------------------------------------
# ComfyUI Remote Helpers
# ------------------------------------------------------------------------------

comfyui_ssh() {
	ssh -N \
		-L "${REMOTE_LOCAL_PORT}:127.0.0.1:${REMOTE_WEB_PORT}" \
		-p "$REMOTE_SSH_PORT" \
		"$REMOTE_SSH_USER@$REMOTE_SSH_HOST"
}

comfyui_mount() {
	if ! command -v sshfs >/dev/null 2>&1; then
		echo "sshfs is not installed."
		return 1
	fi

	mkdir -p "$REMOTE_MOUNT_DIR"

	if command -v mountpoint >/dev/null 2>&1 && mountpoint -q "$REMOTE_MOUNT_DIR"; then
		echo "Already mounted at $REMOTE_MOUNT_DIR"
		return 0
	fi

	sshfs \
		-p "$REMOTE_SSH_PORT" \
		-o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3,follow_symlinks \
		"$REMOTE_SSH_USER@$REMOTE_SSH_HOST:$REMOTE_DIR" \
		"$REMOTE_MOUNT_DIR"
}

comfyui_unmount() {
	if command -v mountpoint >/dev/null 2>&1 && ! mountpoint -q "$REMOTE_MOUNT_DIR"; then
		echo "Not mounted: $REMOTE_MOUNT_DIR"
		return 0
	fi

	if command -v fusermount >/dev/null 2>&1; then
		fusermount -u "$REMOTE_MOUNT_DIR"
	else
		umount "$REMOTE_MOUNT_DIR"
	fi
}
