#!/bin/bash -x

# This script is run on the actual server (e.g. production one).

# Constants
FNM_VERSION=v1.37.1

# Change to project directory.
cd "$(dirname $0)/.."

# Get project name via directory's name.
PROJECT_NAME="$(basename $(realpath .))"

# Node.js project
if [[ -f .nvmrc ]]; then
    # Install fnm if not installed.
    if [[ "$(uname -m)" = "x86_64" ]]; then
        ( file ~/.fnm/fnm | grep x86-64 ) || ( cd /tmp; rm -f fnm-linux.zip; wget -c https://github.com/Schniz/fnm/releases/download/${FNM_VERSION}/fnm-linux.zip; mkdir ~/.fnm; unzip -o fnm-linux.zip -d ~/.fnm/; chmod 755 ~/.fnm/fnm )
    elif [[ "$(uname -m)" = "aarch64" ]]; then
        ( file ~/.fnm/fnm | grep aarch64 ) || ( cd /tmp; rm -f fnm-linux.zip; wget -c https://github.com/Schniz/fnm/releases/download/${FNM_VERSION}/fnm-arm64.zip; mkdir ~/.fnm; unzip -o fnm-arm64.zip -d ~/.fnm/; chmod 755 ~/.fnm/fnm )
    else
        echo "Unknown machine type, uname -m: $(uname -m)" >&2
        exit 1
    fi

    # Load fnm.
    eval "$(~/.fnm/fnm env --shell=bash --use-on-cd)"
    export PATH="${HOME}/.fnm:${PATH}"

    # Install node if not installed, also set to default.
    _NODE_VERSION=$(cat .nvmrc)
    fnm default "${_NODE_VERSION}" || ( fnm install "${_NODE_VERSION}"; fnm default "${_NODE_VERSION}" )
fi

# Get git branch name and setup .env
BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
cp ".env.${BRANCH_NAME}" .env

# Setup systemd-related things.
mkdir -p ~/.config/systemd/user
cat > ~/.config/systemd/user/"${PROJECT_NAME}".service <<EOF
#
# This file is auto-generated by setup.sh
[Unit]
Description=${PROJECT_NAME}

[Service]
ExecStart=/home/service-${PROJECT_NAME}/.fnm/fnm exec npx pm2 start ecosystem.config.js
Restart=on-failure
RestartSec=1
Type=forking
WorkingDirectory=/home/service-${PROJECT_NAME}/${PROJECT_NAME}

[Install]
WantedBy=default.target
EOF
systemctl --user daemon-reload
systemctl --user enable --now "${PROJECT_NAME}.service"

# Restart service.
systemctl --user restart "${PROJECT_NAME}.service"
