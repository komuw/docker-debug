#!/usr/bin/env bash
shopt -s nullglob globstar
set -x # have bash print command been ran
set -e # fail if any command fails

export DEBIAN_FRONTEND=noninteractive

MY_NAME=$(whoami)

git clone https://github.com/robbyrussell/oh-my-zsh.git /home/$MY_NAME/.oh-my-zsh
git clone https://github.com/zsh-users/zsh-autosuggestions /home/$MY_NAME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions /home/$MY_NAME/.oh-my-zsh/custom/plugins/zsh-completions

echo '
export ZSH="/home/$MY_NAME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
HIST_STAMPS="dd/mm/yyyy"
plugins=(
git
zsh-autosuggestions
zsh-completions
)
source $ZSH/oh-my-zsh.sh
export PATH
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
' >>  /home/$MY_NAME/.zshrc

chown -R $MY_NAME:$MY_NAME /home/$MY_NAME/.zshrc
chown -R $MY_NAME:$MY_NAME /home/$MY_NAME/.oh-my-zsh

chsh -s $(which zsh)
