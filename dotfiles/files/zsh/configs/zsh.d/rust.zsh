# rust.zsh

export PATH="$HOME/.cargo/bin:$PATH"

if [[ $(uname) == 'Darwin' ]]; then
  # Mac
  export RUST_SRC_PATH=${HOME}/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src
  export DYLD_LIBRARY_PATH=${HOME}/.rustup/toolchains/stable-x86_64-apple-darwin/lib
  export RLS_ROOT=${HOME}/git/rust/rls
elif [[ $(uname) == 'Linux' ]]; then
  # Linux
  export RUST_SRC_PATH=${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src
  export DYLD_LIBRARY_PATH=${HOME}/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib
  export RLS_ROOT=${HOME}/git/rust/rls
fi
