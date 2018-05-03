#!/usr/bin/env bash
# Install maven

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../_setup/utils.sh"

set -e

install_rust () {
    curl https://sh.rustup.rs -sSf | sh
    success "[rust] Successfull installed"
}


install_rust_components () {
    rustup update

    packages=(
        rls-preview
        rust-analysis
        rust-src
        rustfmt-preview
    )

    rustup component add "${packages[@]}"
    success "[rust] Rust components are up to date"
}


info "[rust] Running rust installer"
if test ! $(which rustc)
then
    install_rust
fi

install_rust_components
