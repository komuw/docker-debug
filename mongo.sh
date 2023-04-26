#!/usr/bin/env bash
shopt -s nullglob globstar
set -x # have bash print command been ran
set -e # fail if any command fails


arch="$1"


# Taken from;
# - https://www.mongodb.com/try/download/shell
# - https://www.mongodb.com/try/download/database-tools

# The list of installed tools is: https://www.mongodb.com/docs/database-tools/
# - mongodump     - export of the contents of a mongo db.
# - mongorestore  - restores data from a mongodump to db.
# - bsondump      - convert bson dump files to json.
# - mongoimport   - imports content from an extended JSON, CSV, or TSV export file.
# - mongoexport   - produces a JSON, CSV, export 
# - mongostat     - provide a quick overview of the stus of a running mongo db instance.
# - mongotop      - provide an overview of the time a mongo instance spends reading and writing data.
# - mongofiles    - supports manipulating files stored in your MongoDB instance in GridFS objects.

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

# add aliases
echo "
alias mongo='/usr/bin/mongosh'
alias mongosh='/usr/bin/mongosh'
alias mongodump='/usr/bin/mongodump'
alias mongoexport='/usr/bin/mongoexport'
alias mongofiles='/usr/bin/mongofiles'
alias mongoimport='/usr/bin/mongoimport'
alias mongorestore='/usr/bin/mongorestore'
alias mongostat='/usr/bin/mongostat'
alias mongotop='/usr/bin/mongotop'
" >> ~/.bash_aliases

. ~/.bash_aliases
source ~/.bash_aliases
