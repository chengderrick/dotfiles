#!/usr/bin/env bash
cd "$(dirname "$0")"
git pull origin master

function syncHome() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" -av --no-perms . ~
  source ~/.zshrc
}

function plugMe() {
  vim +PlugInstall +qall
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  syncHome
  plugMe
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    syncHome
    plugMe
  fi
fi
unset syncHome plugMe
