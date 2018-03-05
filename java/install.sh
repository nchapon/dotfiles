#!/usr/bin/env bash
# Install maven

source $HOME/.dotfiles/env

set -e

install_mvn () {
    TEMPORARY_DIRECTORY="/tmp"
    DOWNLOAD_TO="$TEMPORARY_DIRECTORY/maven.tgz"

    info "Downloading Maven to: $DOWNLOAD_TO"

    wget -O "$DOWNLOAD_TO" http://apache.mediamirrors.org/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz

    info 'Extracting Maven'
    tar xzf $DOWNLOAD_TO -C $TEMPORARY_DIRECTORY
    rm $DOWNLOAD_TO

    mkdir -p $HOME/opt
    mv $TEMPORARY_DIRECTORY/apache-maven-* $HOME/opt/maven

    success "[java] maven is installed in : $HOME/opt/maven"
}

info "[java] Running java installer"
if test ! $(which mvn)
then
    install_mvn
else
    success "[java] maven is already installed"
fi
