#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"
source variables.sh

stats_opt=(
    --stats
)

# use newer rsync from brew, it can show progress
# TODO detect version so that this also works on linux
if hash brew >/dev/null; then
    brewpath="$(brew --prefix)"
    if [[ -x "$brewpath/opt/rsync/bin/" ]]; then
        stats_opt+=( --info=progress2 )
        export PATH="$brewpath/opt/rsync/bin/:$PATH"
    fi
fi

rsync -az --del \
    "${stats_opt[@]}" \
    --bwlimit $bwlimit \
    output/ "$game_server_user@$game_server":"$game_server_output_path"
