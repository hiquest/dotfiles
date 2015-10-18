#!/bin/bash

set -e

git log --no-merges --format="%cd" --date=short --author=$1 | sort -u -r | head -n 31 | while read d ; do
  printf "\n[$d]\n"
  GIT_PAGER=cat git h --no-merges --since="$d 00:00:00" --author=$1 --until="$d 24:00:00"
  printf "\n"
done
