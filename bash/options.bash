# Bash Options

## SANE HISTORY DEFAULTS ##

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
# Avoid duplicate entries
export HISTCONTROL="erasedups:ignoreboth"


# append to the history file, don't overwrite it
shopt -s histappend

# Use one command per line
shopt -s cmdhist

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=500000
export HISTFILESIZE=100000

# Exclude ls, job controls and history itself
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Store history immediatly
PROMPT_COMMAND='history -a'

# Don't record some commands


# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
# HISTTIMEFORMAT='%F %T '
