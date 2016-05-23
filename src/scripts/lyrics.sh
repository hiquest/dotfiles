#!/bin/bash
set -e

# Looks up the lyrics for the current playing song in iTunes and prints it out.
# Usage:
#   ./lyrics.sh

escape_uri() {
  perl -MURI::Escape -e 'print uri_escape($ARGV[0]);' "$1"
}

osa() {
  osascript -l JavaScript -e "$1"
}

artist() {
  osa 'Application("iTunes").currentTrack.artist()'
}

name() {
  osa 'Application("iTunes").currentTrack.name()'
}

artist=`artist`
artist=`echo $artist | sed 's/&/And/g'`
artist=`escape_uri "$artist"`

name=`name`
name=`escape_uri "$name"`

lyrics_url="http://makeitpersonal.co/lyrics?artist=$artist&title=$name"

curl -s $lyrics_url | less
