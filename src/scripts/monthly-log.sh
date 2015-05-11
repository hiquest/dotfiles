#!/bin/sh

set -e

git log --no-merges --format="%cd" --date=short --author=$1 | sort -u -r | head -n 31 | while read DATE ; do
  echo
  echo "[$DATE]"
  GIT_PAGER=cat git h --no-merges --since="$DATE 00:00:00" --author=$1 --until="$DATE 24:00:00"
  echo
done
