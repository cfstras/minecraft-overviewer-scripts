#!/bin/bash
set -euo pipefail
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
cd "$SCRIPT_DIR"

if [[ ! -s variables.sh ]]; then
  cat <<EOF
variables.sh was not found!!

I am creating one for you, based on the example file.
Please change the config, and then run this script again.
EOF
  cp -v variables.example.sh variables.sh
  exit 1
fi

set -x
source variables.sh
######################################

# always use ssh -A, in case the user has SSH control sockets enabled
SSH="ssh -A -o StrictHostKeyChecking=no"

target=/world
compute_ssh=$compute_server_user@$compute_server
game_ssh=$game_server_user@$game_server


echo "======== compiling stuff ========="
rsync -e "$SSH" -avP build.sh config.py $compute_ssh:/
$SSH $compute_ssh /build.sh
echo "======== compiling done ========="

echo "======== uploading world ========="
$SSH $game_ssh "rsync -e '$SSH' --del -az --partial $game_server_world_path $compute_ssh:$target/"
$SSH $game_ssh "rsync -e '$SSH' --del -az --partial $game_server_output_path $compute_ssh:/output/"
echo "======== uploading done ========="


echo "========== starting render ========="

$SSH $compute_ssh "nice -n5 /overviewer/overviewer.py --config=/config.py --genpoi"
$SSH $compute_ssh "nice -n5 /overviewer/overviewer.py --config=/config.py"

echo "========== done, transferring stuff... ========="

ssh $compute_ssh "rsync -e '$SSH' -a --del --exclude '*.tmp' --delete-excluded /output/ $game_ssh:$game_server_output_path"

echo "transfer done, you can kill the server now"
