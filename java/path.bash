#!/usr/bin/env bash


# Java on OS X
if [[ -f /usr/libexec/java_home ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
else
    export JAVA_HOME="/opt/jdk1.8.0_152"
fi


export M2_HOME=$HOME/opt/maven
export PATH="$M2_HOME/bin:$JAVA_HOME/bin:$PATH"
