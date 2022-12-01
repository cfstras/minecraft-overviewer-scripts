#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"

source variables.sh

if pgrep run_local.sh; then
    exit
    echo "already running!"
fi

cd "$overviewer_path"
nice -n10 ./overviewer.py "${overviewer_args[@]}" --config=../config.py --genpoi
nice -n10 ./overviewer.py "${overviewer_args[@]}" --config=../config.py
