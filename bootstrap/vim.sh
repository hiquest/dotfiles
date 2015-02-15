#!/bin/bash

set -e

# Installing pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# We will need those dirs
mkdir -p ~/.vim/{backups,swaps,undo}

# Saving old version of .vimrc
if [ -f ~/.vimrc ]; then
  mv ~/.vimrc ~/.vimrc.old
fi

# Copy .vimrc
cp ../.vimrc ~/

# Installing plugins
cat ../vim.plugins | while read l; do cd ~/.vim/bundle/ && git clone $l ; done

