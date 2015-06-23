#!/bin/bash

set -e

BASE='/Users/yanis/Dropbox/edulogs'

list_all() {
  find $BASE -type f | sort -r | xargs cat | vim -
};

view_today() {
  filename=$BASE/`date +%Y_%m_%d`.markdown
  vim $filename
};

if [ "$1" == "list" ]; then
  list_all
else
  view_today
fi
