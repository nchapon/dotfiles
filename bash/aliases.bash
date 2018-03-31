cd "$(dirname "${BASH_SOURCE[0]}")" \
     && . "../env"

alias reload='. ~/.bashrc'
alias cls='clear' # Good 'ol Clear Screen command

alias cdp='cd ~/Projects'

_source _$(get_os)/aliases.bash
