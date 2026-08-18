#!/bin/bash

# Set relative location of assignments folders to be opened in VS code
ASSIGNMENT_DIR="../assignments"

# Check whether path has been set
if [ -z $ASSIGNMENT_DIR ]; then
    echo "Please set (relative) path for your assignment folder first by editing the script you just called"
    exit 1
fi

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Use reset argument to delete vscode config
if [ "$1" = 'reset' ]; then
    rm -rf $SCRIPT_DIR/vsconfig
else
    # Create persistent storage
    mkdir -p $SCRIPT_DIR/vsconfig

    # Get X11 window out on XWayland
    # (adapted from https://oneuptime.com/blog/post/2026-03-18-run-gui-applications-podman-containers/view)
    podman run -it --rm \
        --userns=keep-id \
        -e DISPLAY=$DISPLAY \
        -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:ro \
        -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/runtime/$WAYLAND_DISPLAY:ro \
        --shm-size=2g \
        -v $SCRIPT_DIR/vsconfig:/home/cppcourse/.config/Code:rw \
        -v "$SCRIPT_DIR/$ASSIGNMENT_DIR":/home/cppcourse/assignments:rw \
        cppcourse \
        /home/cppcourse/assignments/$1
fi
