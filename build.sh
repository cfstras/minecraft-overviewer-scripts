#!/bin/bash
set -euxo pipefail

# build from source for maximum performance
apt update
apt install -y git python3-pip python3-pil python3-dev python3-numpy wget

overviewer=/overviewer

if [[ -d $overviewer ]]; then
    cd $overviewer
    git pull
else
    git clone git://github.com/overviewer/Minecraft-Overviewer.git $overviewer
    cd $overviewer
fi


export CFLAGS="-Ofast"
python3 setup.py build

VERSION=1.15
TEXTURE_FILE=~/.minecraft/versions/${VERSION}/${VERSION}.jar

if [[ ! -s $TEXTURE_FILE ]]; then
    mkdir -p ~/.minecraft/versions/${VERSION}/
    wget https://overviewer.org/textures/${VERSION} -O $TEXTURE_FILE
fi
