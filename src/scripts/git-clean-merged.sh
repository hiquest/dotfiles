#!/bin/bash

# Removes merged local branches

git branch --merged | grep -v "\*" | grep "yt-" | xargs -n 1 git branch -d
