#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"

source variables.sh

cd "$overviewer_path"
nice -n10 ./overviewer.py --config=../config.py --genpoi
nice -n10 ./overviewer.py --config=../config.py
