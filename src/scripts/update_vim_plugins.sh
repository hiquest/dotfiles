#!/bin/bash

set -e

ls ~/.vim/bundle |
  xargs -n1 |
  while read l; do
    echo; echo "Updating $l..."
    cd ~/.vim/bundle/$l && git pull && git h ORIG_HEAD.. | head -5
  done
