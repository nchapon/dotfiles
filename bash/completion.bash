#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../env"

_source _$(get_os)/completion.bash
