#!/bin/sh

gpg --card-status
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
gpg-connect-agent reloadagent /bye
gpg-connect-agent updatestartuptty /bye
ssh-add -L