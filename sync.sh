#!/bin/bash

set -e

rm -rf src
mkdir src
cp ~/.vimrc ./src/
cp ~/.gitconfig ./src/
cp ~/.aliases ./src/
cp ~/.oh-my-zsh/custom/themes/yanis.zsh-theme ./src/
cp -rf ~/scripts ./src/

# Getting plugin repo urls, you can then install them all with something like:
# cat vim.plugins | while read l; do git clone $l; done

ls ~/.vim/bundle |
  xargs -n1 |
  while read l; do
    cd ~/.vim/bundle/$l && git remote -v |
      head -n 1 |
      awk '{print $2}'
  done > src/vim.plugins
