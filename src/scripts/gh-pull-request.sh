#!/bin/sh

# Opens pull-request (in browser) from current branch to master.
# Usage:
#   ./gh-pull-request.sh

set -e

project=`git remote -v | grep origin | head -1 | awk '{print $2}' | sed 's/.*github.com.//' | sed 's/\.git//'`
branch=`git rev-parse --abbrev-ref HEAD`
url="https://github.com/$project/compare/$branch?expand=1"
open $url
