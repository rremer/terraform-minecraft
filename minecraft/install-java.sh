#!/bin/bash
#
# Install an older jdk for minecraft >=1.12.2
#

curl "${java_download_url}" -qso jre.tgz
mkdir -p "${java_install_directory}"
tar -xzf jre.tgz -C "${java_install_directory}"
rm -f /usr/bin/java || true
ln -s "${java_install_directory}"/*/bin/java /usr/bin/java
java -version
