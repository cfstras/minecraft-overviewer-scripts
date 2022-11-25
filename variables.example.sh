#!/bin/bash

# replace these variables!

# Path to checkout overviewer
overviewer_path=/overviewer

# minecraft server address
export game_server=my-minecraft-server.com
export game_server_user=mc

# path to the world
export game_server_world_path=/home/mc/Server/world/

# path where the output should be synced to
export game_server_output_path=/home/mc/overviewer/output/

# compute server
export compute_server=99.99.99.99

# only root supported for now, to run apt
export compute_server_user=root

# bandwidth limit in KB/s, for local sync and render upload
export bwlimit=100000
