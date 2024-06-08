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
cd ~/test-githubactions

# Setup systemd.
mkdir -p ~/.config/systemd/user
cp scripts/test-githubactions.service ~/.config/systemd/user
systemctl --user daemon-reload
systemctl --user enable --now test-githubactions.service

# Restart service.
systemctl --user restart test-githubactions.service
