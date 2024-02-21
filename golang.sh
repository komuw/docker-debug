#!/usr/bin/env bash
shopt -s nullglob globstar
set -x # have bash print command been ran
set -e # fail if any command fails

export DEBIAN_FRONTEND=noninteractive

arch="$1"

if [[ $arch == *"arm64"* ]]; then
    GOLANG_VERSION=go1.22.0.linux-arm64
else
    GOLANG_VERSION=go1.22.0.linux-amd64
fi

printf "\n\t install Golang stuff. arch=${arch}.\n\t GOLANG_VERSION=${GOLANG_VERSION} \n"

rm -rf "/usr/local/$GOLANG_VERSION.tar.gz"
rm -rf /usr/local/go
rm -rf /usr/local/go1.*.*gz
wget -nc --output-document="/usr/local/$GOLANG_VERSION.tar.gz" "https://go.dev/dl/$GOLANG_VERSION.tar.gz"
tar -xzf "/usr/local/$GOLANG_VERSION.tar.gz" -C /usr/local/
ln --force --symbolic /usr/local/go/bin/go /usr/local/bin/go
rm -rf /tmp/*

go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
mv ~/go/bin/gofumpt /usr/local/bin
mv ~/go/bin/goimports /usr/local/bin
