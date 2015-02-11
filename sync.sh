#!/bin/bash

set -e

cp ~/.vimrc ./
cp ~/.gitconfig ./
cp ~/.aliases ./
cp ~/.oh-my-zsh/custom/themes/yanis.zsh-theme ./

# Getting plugin repo urls, you can then install them all with something like:
# cat vim.plugins | while read l; do git clone $l; done

ls ~/.vim/bundle |
  xargs -n1 |
  while read l; do
    cd "/Users/yanis/.vim/bundle/$l" && git remote -v |
      head -n 1 |
      awk '{print $2}'
  done > vim.plugins
