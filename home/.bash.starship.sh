# Start Starship prompt and Rust environment.
#
# CARGO_HOME / RUSTUP_HOME default to the system-wide /opt/rust install used
# on shared machines, but are set only if nothing earlier in shell startup
# already pointed them somewhere else. Per-machine ~/.bashrc can set them
# to $HOME/.cargo and $HOME/.rustup before sourcing this file and that wins.
: "${CARGO_HOME:=/opt/rust/.cargo}"
: "${RUSTUP_HOME:=/opt/rust/.rustup}"
export CARGO_HOME RUSTUP_HOME
if [ -f "$CARGO_HOME/env" ]; then
  . "$CARGO_HOME/env"
fi
path_add "$CARGO_HOME/bin"

eval "$(starship init bash)"
