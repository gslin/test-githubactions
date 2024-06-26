# test-githubactions ![default workflow badge](https://github.com/gslin/test-githubactions/actions/workflows/default.yml/badge.svg)

This repository is trying to build a complete pipeline for:

* fnm + Node.js 20 + pm2 + systemd --user
* Deploy your code with GitHub Actions by SSHing to your server.

It should be quite simple and easy to understand, but it's not well-documented, so please read the code carefully.

## Installation (target server)

* Enable SSH port.
* Enable user's systemd.
* Install SSH public key.

## Installation (repository)

* Copy `.github/workflows/default.yml` to your repository.
* Copy `scripts/setup.sh` to your repository.

## CD (GitHub Actions)

### Variable(s)

* `BRANCH_DEVELOP_DEPLOY_SSH_HOSTNAME`
* `BRANCH_DEVELOP_DEPLOY_SSH_PORT`
* `BRANCH_DEVELOP_DEPLOY_SSH_USERNAME`
* `BRANCH_MAIN_DEPLOY_SSH_HOSTNAME`
* `BRANCH_MAIN_DEPLOY_SSH_PORT`
* `BRANCH_MAIN_DEPLOY_SSH_USERNAME`

For example:

    gh variable set BRANCH_DEVELOP_DEPLOY_HOSTNAME -b 'host.example.com'

### Secret(s)

* `BRANCH_DEVELOP_DEPLOY_SSH_PRIVATE_KEY_BASE64`
* `BRANCH_MAIN_DEPLOY_SSH_KEY_PRIVATE_BASE64`

For example:

    base64 -w 0 ~/.ssh/deploy.pem | gh secret set BRANCH_DEVELOP_DEPLOY_SSH_PRIVATE_KEY_BASE64
