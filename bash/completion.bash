#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../_setup/utils.sh"

_source _$(get_os)/completion.bash
