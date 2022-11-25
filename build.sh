#!/bin/bash
set -euxo pipefail

source variables.sh

# build from source for maximum performance
apt update
apt install -y git python3-pip python3-pil python3-dev python3-numpy curl

if [[ -d "$overviewer_path" ]]; then
    cd "$overviewer_path"
    git pull
else
    git clone https://github.com/overviewer/Minecraft-Overviewer.git "$overviewer_path"
    cd "$overviewer_path"
fi

# note: only really necessary if we installed pillow with pip
# curl -fsSLO https://github.com/python-pillow/Pillow/raw/9.3.0/src/libImaging/ImPlatform.h
# curl -fsSLO https://github.com/python-pillow/Pillow/raw/9.3.0/src/libImaging/Imaging.h
# curl -fsSLO https://github.com/python-pillow/Pillow/raw/9.3.0/src/libImaging/ImagingUtils.h

export CFLAGS="-Ofast"
python3 setup.py build

VERSION=1.19.2
TEXTURE_FILE=~/.minecraft/versions/${VERSION}/${VERSION}.jar

if [[ ! -s $TEXTURE_FILE ]]; then
    mkdir -p ~/.minecraft/versions/${VERSION}/
    curl -fSL https://overviewer.org/textures/${VERSION} -o $TEXTURE_FILE
fi
