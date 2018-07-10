# Bash Options

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=1000
export HISTFILESIZE=2000

# Use one command per line
shopt -s cmdhist


# Exclude ls, job controls and history itself
export HISTIGNORE='ls:bg:fg:history'


# Store history immediatly
export PROMPT_COMMAND='history -a'
