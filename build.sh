#!/bin/bash
set -euxo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"

#shellcheck disable=SC1091
source variables.sh
overviewer_path=${overviewer_path:-"$PWD/overviewer"}
MINECRAFT_VERSION=${MINECRAFT_VERSION:-"$VERSION"}  # for backwards compatibility
MINECRAFT_VERSION=${MINECRAFT_VERSION:-1.19.2}
TEXTURE_FILE=${TEXTURE_FILE:-~/.minecraft/versions/${MINECRAFT_VERSION}/${MINECRAFT_VERSION}.jar}

# build from source for maximum performance
apt update
apt install -y git python3-pip python3-pil python3-dev python3-numpy curl build-essential

if [[ -d "$overviewer_path" ]]; then
    cd "$overviewer_path"
    git config pull.rebase false
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

if [[ ! -s "$TEXTURE_FILE" ]]; then
    mkdir -p ~/.minecraft/versions/"${MINECRAFT_VERSION}"/
    curl -fSL "https://overviewer.org/textures/${MINECRAFT_VERSION}" -o "$TEXTURE_FILE"
fi
