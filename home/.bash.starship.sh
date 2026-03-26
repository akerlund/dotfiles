# Start Starship prompt and Rust environment
export CARGO_HOME="/opt/rust/.cargo"
export RUSTUP_HOME="/opt/rust/.rustup"
if [ -f "$CARGO_HOME/env" ]; then
  . "$CARGO_HOME/env"
fi
path_add "$CARGO_HOME/bin"

eval "$(starship init bash)"
