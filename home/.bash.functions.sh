# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

# Function to safely add a directory to PATH
path_add() {
  # Check if the directory exists and is not already in PATH
  if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
    export PATH="$1:$PATH"
  fi
}

# Start the SSH agent if it's not already running
function start_ssh {
  if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
  else
    echo "SSH agent is already running."
  fi
}

# Start a stats monitoring layout in regolith.
stats() {
  i3-msg "split v"
  gnome-terminal --class="stats_nvitop" -- nvitop --monitor full &
  sleep 0.6
  i3-msg "[class=\"stats_nvitop\"] focus"
  i3-msg "split h"
  gnome-terminal --class="stats_aqua" -- asciiquarium &
  sleep 0.5
  i3-msg "[class=\"stats_aqua\"] focus"
  i3-msg "resize set width 33 ppt"
  i3-msg "[class=\"stats_nvitop\"] focus"
  i3-msg "resize shrink height 7 px or 7 ppt"
  sleep 0.5
  i3-msg "focus up"
  exec btop
}

# Auto-activate venvs for known repo roots.
AUTO_VENV_ROOTS=(
  "/home/freake/github/ComfyUI"
  "/home/freake/github/kohya_ss"
  "/home/freake/github/OneTrainer"
)

# Override cd so entering a managed repo automatically enables its venv.
cd() {

  local repo_root target_venv

  # Stop immediately if the directory change fails.
  builtin cd "$@" || return

  # Find the configured repo root that contains the new working directory.
  target_venv=""
  for repo_root in "${AUTO_VENV_ROOTS[@]}"; do
    if [[ "$PWD" == "$repo_root"* ]]; then
      target_venv="$repo_root/venv"
      break
    fi
  done

  if [ -n "$target_venv" ]; then
    # Activate that repo's venv when entering it or one of its subdirectories.
    if [ -f "$target_venv/bin/activate" ] && [ "$VIRTUAL_ENV" != "$target_venv" ]; then
      if [ -n "$VIRTUAL_ENV" ] && command -v deactivate >/dev/null 2>&1; then
        deactivate
      fi
      . "$target_venv/bin/activate"
      echo "🐍 Virtual environment activated: $target_venv"
    fi
  elif [ -n "$VIRTUAL_ENV" ]; then
    # Deactivate only if the active venv belongs to one of the managed repo roots.
    for repo_root in "${AUTO_VENV_ROOTS[@]}"; do
      if [ "$VIRTUAL_ENV" = "$repo_root/venv" ] && command -v deactivate >/dev/null 2>&1; then
        deactivate
        echo "🐍 Virtual environment deactivated."
        break
      fi
    done
  fi
}
