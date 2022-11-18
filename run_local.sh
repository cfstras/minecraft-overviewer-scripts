#!/bin/bash
set -euo pipefail
cd Minecraft-Overviewer
nice -n10 ./overviewer.py --config=../config.py --genpoi
nice -n10 ./overviewer.py --config=..//config.py
