FROM ubuntu:18.04

RUN \
    apt-get update && \
    apt-get -y upgrade

RUN apt-get install -y curl
RUN apt-get install -y iputils-ping 
RUN apt-get install -y openssh-server
RUN apt-get install -y dnsutils
RUN apt-get install -y build-essential


RUN useradd remote_user && \
    echo "remote_user:1234" | chpasswd && \
    mkdir /home/remote_user/.ssh -p && \
    chmod 700 /home/remote_user/.ssh && \
    mkdir -p -m0755 /var/run/sshd


# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

RUN wget http://download.redis.io/redis-stable.tar.gz
RUN tar xzf redis-stable.tar.gz
RUN cd redis-stable && make
RUN cp redis-stable/src/redis-cli /usr/local/bin

# Define default command.
CMD /usr/sbin/sshd -D
