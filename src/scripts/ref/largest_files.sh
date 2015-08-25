#!/bin/bash

set -e

ft=${1:-rb}

count_lines() {
  while read l; do              \
    echo "`cat $l | wc -l` $l"; \
  done                          \
}

find . -name "*.$ft" \
  | count_lines      \
  | sort -g          \
  | awk '$1 > 80'    \
