#!/bin/bash

set -eo pipefail

cd $RUNNER_TEMP

# # install deps
# mkdir -p /etc/apt/keyrings
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
# echo \
#   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# chmod a+r /etc/apt/keyrings/docker.gpg
# apt-get update
# apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# # install openlane
# mkdir -p /opt
# cd /opt
# git clone https://github.com/The-OpenROAD-Project/OpenLane

# pushd OpenLane
#     make
# popd

# install pdk
PDK_ROOT=/opt/pdk

mkdir -p $PDK_ROOT
pushd $PDK_ROOT
    git clone https://github.com/google/skywater-pdk.git
    pushd skywater-pdk
        git checkout 00bdbcf4a3aa922cc1f4a0d0cd8b80dbd73149d3
        git submodule update --init libraries/sky130_fd_sc_hd/latest
        git submodule update --init libraries/sky130_fd_sc_hvl/latest
        git submodule update --init libraries/sky130_fd_io/latest
        #make timing
    popd
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
