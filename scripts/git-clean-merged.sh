#!/bin/bash

# Removes merged local branches

set -e

git checkout master
git pull --prune
git branch --merged | grep -v "\*" | grep "yt-" | xargs -n 1 git branch -d
