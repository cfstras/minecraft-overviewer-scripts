# Minecraft Overviewer

This repo contains scripts to do a one-off render on a powerful remote box.

## How To

1. If you haven't already, set up SSH-Key authentication on your game server.  
    - Make sure you can log in without a password.
    - You will also need an SSH-Agent running, with your private key(s) added.
    - The script will use the agent in order to transfer data directly between
      your gameserver and your compute server, without going through your local computer.

1. Run `./run.sh` once, to create the example config.

1. Open `variables.sh` and put in your values.
    - `compute_server` will be the IP of your compute server. We will set that later.

1. Open `config.py` and amend any settings for your render, if you want to.

1. Rent a powerful compute server on your favorite cloud provider.
    - If your world is big, the GP1-L (32 cores) for 60ct/hour on Scaleway would be an example.
    - This is where it gets costly!
        - If you want to interrupt your work, delete the server.
        - Once a render is finished, the output will be transferred automatically.
        - You can also copy back the output folder manually.
    - The OS should be debian buster or newer, or another debian-compatible distro.
    - The disk should be big enough to hold your world and the output.
      - The output will be around 2-3x the size of your world.

1. Make sure you can connect to the compute server with SSH-Key authentication.
    - Set the IP in `variables.sh` under `compute_server = ...`

1. Call `./run.sh` on your local machine  
  The script will now do the following steps:
    1. Compile and install overviewer on the compute server
    1. Transfer the world directly from the game server to the compute server
        - If it is available, the output will also be transferred, to speed up the render.
    1. Render the world, along with POIs
    1. Transfer the output back to your game server

1. After you're done, don't forget to delete your compute server!

---
