#!/bin/bash

# Checkout a branch by partial name.
# Usage:
#   ./gco.sh <part_of_branch_name>

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
