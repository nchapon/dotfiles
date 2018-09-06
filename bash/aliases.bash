cd "$(dirname "${BASH_SOURCE[0]}")" \
     && . "../_setup/utils.sh"

alias reload='. ~/.bashrc'
alias cls='clear' # Good 'ol Clear Screen command

alias cdp='cd ~/Projects'
alias magit='emacsclient -a emacs -e "(progn (magit-status \"$(git rev-parse --show-toplevel)\") (delete-other-windows))"'


_source _$(get_os)/aliases.bash
