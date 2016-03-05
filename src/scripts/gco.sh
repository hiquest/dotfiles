#!/bin/bash

set -e

grep_branches()
{
  git branch | grep $1
}

co_first() {
  grep_branches $1 \
    | head -n 1 \
    | xargs git checkout
}

if [ "$1" = "-" ]
then
  git checkout -
else
  co_first $1
fi
