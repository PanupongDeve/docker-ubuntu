FROM ubuntu:18.04

RUN \
    apt-get update && \
    apt-get -y upgrade

RUN apt-get install -y curl
RUN apt-get install -y iputils-ping 
RUN apt-get install -y openssh-server

RUN useradd remote_user && \
    echo "remote_user:1234" | chpasswd && \
    mkdir /home/remote_user/.ssh -p && \
    chmod 700 /home/remote_user/.ssh && \
    mkdir -p -m0755 /var/run/sshd


# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Define default command.
CMD /usr/sbin/sshd -D