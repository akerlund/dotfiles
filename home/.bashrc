# Path to your shared dotfiles
DOTS="/home/freake/github/dotfiles/home"

# 1. Functions (Logic)
[ -f "$DOTS/.bash.functions.sh" ] && . "$DOTS/.bash.functions.sh"

# 2. Environment and Exports (Foundation)
[ -f "$DOTS/.bash.exports.sh" ] && . "$DOTS/.bash.exports.sh"

# 3. Aliases (Shortcuts)
[ -f "$DOTS/.bash.aliases.sh" ] && . "$DOTS/.bash.aliases.sh"

# 4. Starship
[ -f "$DOTS/.bash.starship.sh" ] && . "$DOTS/.bash.starship.sh"

# Clean up variable
unset DOTS
