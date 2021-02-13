FROM alpine/git

USER root

# INSTALL SSH
RUN apk add openssh --no-cache

# INSTALL OPENSSL
RUN apk add openssl

# ENABLE PASSWORDLESS SSH ACCESS
RUN echo "UseDNS no" >> /etc/ssh/sshd_config
RUN echo "Port 4444" >> /etc/ssh/sshd_config

# GENERATE HOST KEYS
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

# ENTRYPOINT
COPY docker-entrypoint.sh /
RUN chmod 700 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
