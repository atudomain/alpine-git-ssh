#!/usr/bin/env sh

# SET RANDOM PASSWORD FOR git OR NO SSH
echo "git:$(openssl rand -base64 64)"|chpasswd

# GENERATE git USER KEYS IF NOT EXIST
if [ ! -f "/home/git/.ssh/id_rsa" ]; then
    ssh-keygen -q -f "/home/git/.ssh/id_rsa" -C '' -N '' -t rsa
    cat /home/git/.ssh/id_rsa.pub > /home/git/.ssh/authorized_keys
    chmod 700 /home/git/.ssh
    chmod 600 /home/git/.ssh/authorized_keys
    chown -R git:git /home/git
fi

# CREATE REPOSITORY IF NOT EXISTS
if [ ! -d /repo/.git ]; then
    mkdir -p /repo
    cd /repo && git init --initial-branch=master
    chown -R git:git /repo
fi

# START SSH DAEMON
/usr/sbin/sshd -D
