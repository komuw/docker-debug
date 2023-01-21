FROM ubuntu:22.04

# docker buildx create --use --name multi-arch-builder
# docker buildx build --push --platform linux/amd64,linux/arm64 -t komuw/debug:latest .
#
# docker build -t komuw/debug:latest .
# docker \
#     run \
#     -it \
#     komuw/debug:latest

WORKDIR /app

RUN apt -y update && \
    apt -y install \
    lsof \
    screen \
    telnet \
    curl \
    wget \
    iputils-ping \
    dnsutils \
    psmisc \
    net-tools \
    tree \
    strace \
    wireshark && \
    apt -y autoremove && \
    apt -y clean && \
    apt -y autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

# Taken from; https://www.mongodb.com/try/download/bi-connector
RUN wget -nc --output-document=/tmp/mongo_tools.deb "https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.6.1.deb" && \
    wget -nc --output-document=/tmp/mongo_shell.deb "https://downloads.mongodb.com/compass/mongodb-mongosh_1.6.2_amd64.deb" && \
    dpkg -i /tmp/mongo_tools.deb && \
    dpkg -i /tmp/mongo_shell.deb && \
    rm -rf /tmp/mongo_tools.deb && \
    rm -rf /tmp/mongo_shell.deb

CMD ["/bin/bash"]

