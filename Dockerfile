
FROM alpine:latest

EXPOSE 999/tcp
ENTRYPOINT /usr/sbin/sshd -D -p 999

RUN <<EOF
  apk add openssh
  mkdir /root/.ssh
  echo \
    'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAuOPGTa4z//SThl3fC4T5rjPTwhJcSxNd6H9eCP6qOj' \
    > /root/.ssh/authorized_keys
  chmod 600 /root/.ssh
  chmod 600 /root/.ssh/authorized_keys
  ssh-keygen -A

  echo "PasswordAuthentication no" > /etc/ssh/sshd_config.d/00.conf
  echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config.d/00.conf
EOF
