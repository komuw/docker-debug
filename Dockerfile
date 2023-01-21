FROM ubuntu:22.04

# docker buildx create --use --name multi-arch-builder
# docker buildx build --platform linux/amd64,linux/arm64 -t komuw/debug:latest .
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

CMD ["/bin/bash"]

