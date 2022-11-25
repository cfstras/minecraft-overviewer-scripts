#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"

source variables.sh

mkdir -p output
rsync \
    "$game_server_user@$game_server":"$game_server_world_path/../usercache.json" "output/usercache.json"
rsync -az --progress --partial --del \
    --bwlimit $bwlimit \
"$game_server_user@$game_server":"$game_server_world_path" world/
