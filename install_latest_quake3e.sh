#!/bin/bash

# Name     : install_latest_quake3e.sh
# Date     : 1/30/2025
# Author   : Trismegist0s 
# Purpose  : Automatically clone latest version of Quake3e from Github repository, build, and install the compiled executable

set -e  # Exit script if any command fails
GAME_DIR="${HOME}/Games/quake3e"
INSTALL_DIR="/games/quake3e"
REPO_URL="https://github.com/ec-/Quake3e.git"

# Ensure the Games directory exists
mkdir -p "${HOME}/Games"

# Function to log messages in green
log() {
    echo -e "\033[1;32m[INFO] $1\033[0m"
}

log "Removing any existing ioq3 directory..."
rm -rf "${GAME_DIR}"

log "Cloning Quake3e repository..."
git clone "${REPO_URL}" "${GAME_DIR}"

log "Entering ioq3 directory..."
cd "${GAME_DIR}"

log "Starting build with $(nproc) cores..."
export COPYDIR="${INSTALL_DIR}"
make -j"$(nproc)"

log "Copying files to ${INSTALL_DIR} (requires sudo)..."

make install DESTDIR=${INSTALL_DIR}

log "Build and installation completed successfully."
