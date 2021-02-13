#!/usr/bin/env sh

# SET RANDOM PASSWORD FOR ROOT OR NO SSH
echo "root:$(openssl rand -base64 64)"|chpasswd

# GENERATE git USER KEYS IF NOT EXIST
if [ ! -f "/root/.ssh/id_rsa" ]; then
    ssh-keygen -q -f "/root/.ssh/id_rsa" -C '' -N '' -t rsa
    cat /root/.ssh/id_rsa.pub > /root/.ssh/authorized_keys
    chmod 700 /root/.ssh
    chmod 600 /root/.ssh/authorized_keys
fi

# CREATE REPOSITORY IF NOT EXISTS
if [ ! -d /repo/.git ]; then
    mkdir -p /repo
    cd /repo && git init --initial-branch=master
fi

# START SSH DAEMON
/usr/sbin/sshd -D
