FROM ubuntu:22.04

LABEL repo="github.com/komuw/docker-debug"

# docker buildx create --use --name multi-arch-builder
# docker buildx build --push --platform linux/amd64,linux/arm64 -t komuw/debug:latest .
#
# docker \
#     run \
#     -it \
#     komuw/debug:latest

WORKDIR /app

COPY mongo.sh .
COPY oh_my_zsh.sh .

# The arg is provided by docker:
# https://docs.docker.com/engine/reference/builder/#automatic-platform-args-in-the-global-scope
ARG TARGETPLATFORM

RUN printf "\n\n\t The target platform is: $TARGETPLATFORM \n\n" && \
    export DEBIAN_FRONTEND=noninteractive && \
    apt -y update && \
    apt -y install \
    nano \
    lsof \
    screen \
    telnet \
    mtr \
    curl \
    wget \
    iputils-ping \
    dnsutils \
    psmisc \
    net-tools \
    tree \
    strace \
    tcpdump \
    redis-tools \
    tshark \
    git \
    zsh && \
    apt -y autoremove && \
    apt -y clean && \
    apt -y autoclean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN bash /app/mongo.sh $TARGETPLATFORM && \
    bash /app/oh_my_zsh.sh && \
    export SHELL=/usr/bin/zsh && \
    chsh -s $(which zsh) && \
    export SHELL=/usr/bin/zsh

CMD ["/usr/bin/zsh"]
