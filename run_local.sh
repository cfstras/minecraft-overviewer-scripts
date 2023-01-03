#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"

#shellcheck disable=SC1091
source variables.sh
overviewer_path=${overviewer_path:-"$PWD/overviewer"}
declare -ga overviewer_args=( "${overviewer_args[@]}" )

if pgrep run_local.sh | grep -v $$; then
    echo "already running!"
    exit
fi

cd "$overviewer_path"
nice -n10 ./overviewer.py "${overviewer_args[@]}" --config=../config.py --genpoi
nice -n10 ./overviewer.py "${overviewer_args[@]}" --config=../config.py
