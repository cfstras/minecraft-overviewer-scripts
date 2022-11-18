#!/bin/bash
set -euo pipefail
cd Minecraft-Overviewer
nice -n5 ./overviewer.py --config=../config.py --genpoi
nice -n5 ./overviewer.py --config=..//config.py
