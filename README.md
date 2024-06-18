# test-githubactions ![default workflow badge](https://github.com/gslin/test-githubactions/actions/workflows/default.yml/badge.svg)

## Variable(s)

* `BRANCH_DEVELOP_DEPLOY_SSH_HOSTNAME`
* `BRANCH_DEVELOP_DEPLOY_SSH_PORT`
* `BRANCH_DEVELOP_DEPLOY_SSH_USERNAME`
* `BRANCH_MAIN_DEPLOY_SSH_HOSTNAME`
* `BRANCH_MAIN_DEPLOY_SSH_PORT`
* `BRANCH_MAIN_DEPLOY_SSH_USERNAME`

For example:

    gh variable set BRANCH_DEVELOP_DEPLOY_HOSTNAME -b 'host.example.com'

## Secret(s)

* `BRANCH_DEVELOP_DEPLOY_SSH_PRIVATE_KEY_BASE64`
* `BRANCH_MAIN_DEPLOY_SSH_KEY_PRIVATE_BASE64`

For example:

    base64 -w 0 ~/.ssh/deploy.pem | gh secret set BRANCH_DEVELOP_DEPLOY_SSH_PRIVATE_KEY_BASE64
