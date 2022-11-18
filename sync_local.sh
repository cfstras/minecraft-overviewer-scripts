#!/bin/bash
set -euo pipefail
source variables.sh

mkdir -p output
rsync "$game_server_user@$game_server":"$game_server_world_path/../usercache.json" "output/usercache.json"
rsync -az --progress --partial --del "$game_server_user@$game_server":"$game_server_world_path" world/
