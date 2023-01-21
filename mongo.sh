#!/usr/bin/env bash
shopt -s nullglob globstar
set -x # have bash print command been ran
set -e # fail if any command fails


arch="$1"


# Taken from;
# - https://www.mongodb.com/try/download/shell
# - https://www.mongodb.com/try/download/database-tools

mongo_tools_url="https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-x86_64-100.6.1.deb"
mongo_shell_url="https://downloads.mongodb.com/compass/mongodb-mongosh_1.6.2_amd64.deb"
if [[ $arch == *"arm64"* ]]; then
    mongo_tools_url="https://fastdl.mongodb.org/tools/db/mongodb-database-tools-ubuntu2204-arm64-100.6.1.deb"
    mongo_shell_url="https://downloads.mongodb.com/compass/mongodb-mongosh_1.6.2_arm64.deb"
else
  echo -n ''
fi

printf "\n\t install mongo stuff. arch=${arch}.\n\t mongo_tools_url=${mongo_tools_url} \n\t mongo_shell_url=${mongo_shell_url} \n"

wget -nc --output-document=/tmp/mongo_tools.deb "${mongo_tools_url}"
wget -nc --output-document=/tmp/mongo_shell.deb "${mongo_shell_url}"                                              
dpkg -i /tmp/mongo_tools.deb
dpkg -i /tmp/mongo_shell.deb
rm -rf /tmp/mongo_tools.deb
rm -rf /tmp/mongo_shell.deb
