# cd "$(dirname "${BASH_SOURCE[0]}")" \
#     && . "../env"

declare -r CURRENT_DIR="$(dirname "${BASH_SOURCE[0]}")"


alias reload='. ~/.bashrc'
alias cls='clear' # Good 'ol Clear Screen command

alias cdp='cd ~/Projects'

_source ${CURRENT_DIR}/_$(get_os)/aliases.bash
