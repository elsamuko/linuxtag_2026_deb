#!/usr/bin/env bash

set -e

# keep sudo available
sudo -v
while true; do
  sudo -n true
  sleep 60
  kill -0 "$$" 2>/dev/null || exit
done &
SUDO_LOOP_PID=$!
trap 'kill "$SUDO_LOOP_PID" 2>/dev/null' EXIT INT TERM

FOLDERS=(
    simple
    service
    dh_simple
    dh_service
    dh_python
    dh_python_venv
)

for FOLDER in "${FOLDERS[@]}"; do
    echo "Building $FOLDER"
    (
        cd "$FOLDER" || exit
        ./make_deb.sh
        ./test_deb.sh
    )
done
