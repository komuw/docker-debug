#!/usr/bin/env bash
shopt -s nullglob globstar
set -x # have bash print command been ran
set -e # fail if any command fails

export DEBIAN_FRONTEND=noninteractive

git clone https://github.com/robbyrussell/oh-my-zsh.git /root/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions /root/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions /root/.oh-my-zsh/custom/plugins/zsh-completions

echo 'export ZSH="/root/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd/mm/yyyy"
plugins=(
git
zsh-autosuggestions
zsh-completions
)
source $ZSH/oh-my-zsh.sh
{ # try
  source ~/.bash_aliases
} || { # catch
  echo -n ""
}
export PATH
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export SHELL=/usr/bin/zsh' >>  /root/.zshrc

chown -R root:root /root/.zshrc
chown -R root:root /root/.oh-my-zsh

chsh -s $(which zsh)

# seed history
echo -n > /root/.zsh_history
echo -n > /root/.bash_history
SEED='grep -rsIin "hello" /tmp
ls -lsha ~/
dpkg --get-selections | grep -v deinstall #list all installed packages/programs
ps auxwwwww | grep "vlc"
pstree -pal
fuser -k 8080/tcp #kill whatever is using that port
sed "s/day/night/g" <cool.txt >new.txt #replace day with night. `g` replaces multiple occurences in same line
curl -vkIL https://example.com
wget -nc --output-document=/tmp/some_file.txt https://example.com
screen -ls
screen -S hello
screen -r 2049672 # ctrl-A-D
netstat -tunapl | grep -i 'listen'
lsof -i tcp | grep -i 'listen'
ss --listening --processes --tcp
telnet example.com 80
mtr -r -w --show-ips example.com'
echo "$SEED" >> /root/.zsh_history
echo "$SEED" >> /root/.bash_history
