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
