#!/bin/bash

set -eo pipefail

cd $RUNNER_TEMP

# install openlane
cd /opt
pushd openlane
  expect openlane.exp
  make pdk
popd

# install caravel
git clone https://github.com/efabless/caravel_user_project.git -b mpw-7a
cd caravel_user_project
make install pdk-with-volare

# install oss suite
mkdir -p .setup-oss-cad-suite
pushd .setup-oss-cad-suite

case $TARGETARCH in
    "amd64")
    arch=x64
    ;;
    "arm64") 
    arch=arm64
    ;;
esac

build=`curl -s https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | grep browser_download_url | grep linux-$arch | cut -f4 -d\"`

wget --no-check-certificate $build -O build.tgz
tar xfz build.tgz
rm build.tgz

mv oss-cad-suite /opt
popd
