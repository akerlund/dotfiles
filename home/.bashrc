

# ------------------------------------------------------------------------------
# Alias and Functions
# ------------------------------------------------------------------------------

alias rbash='source ~/.bashrc'
alias ebash='vim ~/.bashrc'
alias estar='vim ~/.config/starship.toml'
alias maxgpu='nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" > /dev/null 2>&1'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'
alias .........='cd ../../../../../../../../'

function setup_ssh_agent {
  if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)"
  else
    echo "SSH agent is already running."
  fi
}

alias start_ssh='setup_ssh_agent'
alias checkdns='echo "Lokal IP:  $(curl -s https://api.ipify.org)" && echo "Loopia IP: $(host akerlund.dev | awk "{print \$NF}")"'
alias sshlog='sudo grep -a "sshd" /var/log/auth.log | tail -n 20'
alias sshfail='sudo grep -a "Failed password" /var/log/auth.log | tail -n 20'

# File management and system monitoring aliases
alias ls='eza --icons --group-directories-first'
alias ll='eza -la --icons --group-directories-first'
alias cat='bat --style=plain'
alias top='btm'
alias du='dust'
#alias grep='rg'
alias find='fd'

# Hex
alias i2h='python3 ~/int_to_hex.py'
alias h2i='python3 ~/hex_to_int.py'

# ------------------------------------------------------------------------------
# Gruvbox colors
# ------------------------------------------------------------------------------

GB_BG='#282828'
GB_RED='\[\033[38;2;251;73;52m\]'
GB_GREEN='\[\033[38;2;184;187;38m\]'
GB_YELLOW='\[\033[38;2;250;189;47m\]'
GB_BLUE='\[\033[38;2;131;165;152m\]'
GB_PURPLE='\[\033[38;2;211;134;155m\]'
GB_AQUA='\[\033[38;2;142;192;124m\]'
GB_ORANGE='\[\033[38;2;254;128;25m\]'
GB_RESET='\[\033[0m\]'
# Gruvbox Prompt
export PS1="${GB_GREEN}\u${GB_RESET}@${GB_AQUA}\h${GB_RESET}:${GB_BLUE}\w${GB_RESET}\$ "
# Gruvbox LS_COLORS
export LS_COLORS="di=1;34:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
alias ls='ls --color=auto'
export TERM=xterm-256color

# ------------------------------------------------------------------------------
# Export Paths and Environment Variables
# ------------------------------------------------------------------------------
# CUDA Paths and Aliases
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Verilator Path
export PATH=$HOME/.local/verilator/bin:$PATH

# Fusesoc
export PATH="$PATH:/home/freake/.local/bin"

# Regolith Terminal Tweaks
# 1. Kill the VTE terminal integration (common lag source in Regolith)
export VTE_VERSION=""

# 2. Ensure no hidden hooks are running on every Enter press
export PROMPT_COMMAND=""

# 3. Use a static, fast prompt (no git calculations or fancy logic)
export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# 4. Final safety check for command-not-found
unset -f command_not_found_handle 2>/dev/null

# ------------------------------------------------------------------------------
# Start a tmux session with a specific layout
# ------------------------------------------------------------------------------
stmux() {
  SESSION="main"

  # 1. Kill and wait for cleanup
  tmux kill-session -t $SESSION 2>/dev/null
  while tmux has-session -t $SESSION 2>/dev/null; do sleep 0.05; done

  # 2. Create session and capture the ID of the first pane
  # Using -P and -F ensures we get the unique pane ID immediately
  P_LEFT_TOP=$(tmux new-session -d -s $SESSION -n 'work' -x "$(tput cols)" -y "$(tput lines)" -P -F "#{pane_id}")

  # 3. Create the grid using the unique IDs
  # Split P_LEFT_TOP to create the right column, capture its ID
  P_RIGHT_TOP=$(tmux split-window -h -t "$P_LEFT_TOP" -P -F "#{pane_id}")

  # Split the left pane vertically to create bottom-left
  tmux split-window -v -t "$P_LEFT_TOP"

  # Split the right pane vertically to create bottom-right
  tmux split-window -v -t "$P_RIGHT_TOP"

  # 4. Finalize layout and colors
  tmux select-layout -t "$SESSION:work" tiled
  tmux set-option -t $SESSION window-style 'bg=#282828'
  tmux set-option -t $SESSION window-active-style 'bg=#282828'

  # 5. Attach
  tmux select-pane -t "$P_LEFT_TOP"
  tmux attach-session -t $SESSION
}

# ------------------------------------------------------------------------------
# Start a stats monitoring layout in regolith.
# ------------------------------------------------------------------------------
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

# Start Starship prompt and Rust environment
. "$HOME/.cargo/env"
eval "$(starship init bash)"
