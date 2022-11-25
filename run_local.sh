#!/bin/bash
set -euo pipefail

source variables.sh

cd "$overviewer_path"
nice -n10 ./overviewer.py --config=../config.py --genpoi
nice -n10 ./overviewer.py --config=../config.py
