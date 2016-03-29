#!/bin/bash
set -e

enc() {
  echo `perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1"`
}

artist=`osascript -e 'tell application "iTunes" to artist of current track as string'`
artist=`enc "$artist"`
name=`osascript -e 'tell application "iTunes" to name of current track as string'`
name=`enc "$name"`

url="http://makeitpersonal.co/lyrics?artist=$artist&title=$name"

curl -s $url
