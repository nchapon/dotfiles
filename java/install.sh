# Install maven

set -e

install_mvn () {
    TEMPORARY_DIRECTORY="/tmp"
    DOWNLOAD_TO="$TEMPORARY_DIRECTORY/maven.tgz"

    echo 'Downloading Maven to: ' "$DOWNLOAD_TO"

    wget -O "$DOWNLOAD_TO" http://apache.mediamirrors.org/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz

    echo 'Extracting Maven'
    tar xzf $DOWNLOAD_TO -C $TEMPORARY_DIRECTORY
    rm $DOWNLOAD_TO

    mkdir -p $HOME/opt
    mv $TEMPORARY_DIRECTORY/apache-maven-* $HOME/opt/maven

    echo 'Maven Installation is installed in: ' "$HOME/opt/maven"
}


if test ! $(which mvn)
then
  install_mvn
fi
