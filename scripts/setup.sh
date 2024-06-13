#!/bin/bash -x

# This script is run on the actual server (e.g. production one).

# Install fnm if not installed.
test -x ~/.fnm/fnm || ( cd /tmp; rm -f fnm-linux.zip; wget -c https://github.com/Schniz/fnm/releases/download/v1.37.0/fnm-linux.zip; mkdir ~/.fnm; unzip fnm-linux.zip -d ~/.fnm/; chmod 755 ~/.fnm/fnm )

# Load fnm.
eval "$(~/.fnm/fnm env --shell=bash --use-on-cd)"
export PATH="${HOME}/.fnm:${PATH}"

# Install node 20 if not installed, also set to default.
fnm default 20 || ( fnm install 20; fnm default 20 )

# Change to project directory.
cd "$(dirname $0)/.."

# Get project name via directory's name.
PROJECT_NAME="$(realpath $0)"

# Setup systemd.
mkdir -p ~/.config/systemd/user
cp "scripts/${PROJECT_NAME}.service" ~/.config/systemd/user
systemctl --user daemon-reload
systemctl --user enable --now "${PROJECT_NAME}.service"

# Restart service.
systemctl --user restart "${PROJECT_NAME}.service"
