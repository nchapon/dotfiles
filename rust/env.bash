#!/usr/bin/env bash
add_path "$HOME/.cargo/bin"

export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
