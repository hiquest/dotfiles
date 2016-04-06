#!/bin/sh

# Opens specified commit in browser.
# Usage:
#   ./gh-view-commit.sh ab3cd31

set -e

project=`git remote -v | grep origin | head -1 | awk '{print $2}' | sed 's/.*github.com.//' | sed 's/\.git//'`
url="https://github.com/$project/commit/$1"
open $url
