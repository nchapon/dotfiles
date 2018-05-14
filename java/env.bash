#!/usr/bin/env bash


# Java on OS X
if [[ -f /usr/libexec/java_home ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
else
    # Java installed /opt or $HOME/opt
    if [[ -d /opt/jdk1.8.0_152 ]]; then
        export JAVA_HOME="/opt/jdk1.8.0_152"
    fi

    if [[ -d $HOME/opt/jdk1.8.0_152 ]]; then
        export JAVA_HOME="$HOME/opt/jdk1.8.0_152"
    fi
fi


export M2_HOME=$HOME/opt/maven

add_path "$M2_HOME/bin"
add_path "$JAVA_HOME/bin"
