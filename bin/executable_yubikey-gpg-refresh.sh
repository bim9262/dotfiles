#!/bin/sh

mkdir -p $GNUPGHOME/private-keys-v1.d.old
[ "$(ls -A $GNUPGHOME/private-keys-v1.d)" ] &&  mv $GNUPGHOME/private-keys-v1.d/* $GNUPGHOME/private-keys-v1.d.old
gpg --card-status
gpgconf --kill gpg-agent
gpgconf --launch gpg-agent
gpg-connect-agent reloadagent /bye
gpg-connect-agent updatestartuptty /bye
ssh-add -L