#!/bin/bash

set -e

home=~/Music/iTunes/iTunes\ Media/Music
ls -1 "$home" | while read art
do
  ls -1 "$home/$art" | while read alb
  do
    count=$(echo -n `ls "$home/$art/$alb" | wc -l`)
    echo "$art — $alb ($count)"
  done
done
