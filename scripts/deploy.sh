#!/bin/bash -x

# Show all environments.
export

# Install fnm if not installed.
test -x ~/.fnm/fnm || ( cd /tmp; rm -f fnm-linux.zip; wget -c https://github.com/Schniz/fnm/releases/download/v1.37.0/fnm-linux.zip; mkdir ~/.fnm; unzip fnm-linux.zip -d ~/.fnm/; chmod 755 ~/.fnm/fnm )

# Load fnm.
eval "$(~/.fnm/fnm env --use-on-cd)"
export PATH="${HOME}/.fnm:${PATH}"

# Install node 20 if not installed, also set to default.
fnm default 20 || ( fnm install 20; fnm default 20 )

cd ~/test-githubactions; npx pm2 restart ecosystem.config.js
