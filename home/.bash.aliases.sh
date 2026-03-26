# ------------------------------------------------------------------------------
# Alias and Functions
# ------------------------------------------------------------------------------

# Reload configurations
alias rbash='source ~/.bashrc'
alias rtmux='tmux source-file ~/.tmux.conf'

# Edit configurations
alias ebash='vim ~/.bashrc'
alias evim='vim ~/.vimrc'
alias estar='vim ~/.config/starship.toml'

# Navigation
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias ........='cd ../../../../../../../'
alias .........='cd ../../../../../../../../'

alias maxgpu='nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" > /dev/null 2>&1'
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
alias i2h="python3 $DOTS/int_to_hex.py"
alias h2i="python3 $DOTS/hex_to_int.py"
