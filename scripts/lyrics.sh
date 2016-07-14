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

itunes_artist() {
  osa 'Application("iTunes").currentTrack.artist()'
}

itunes_name() {
  osa 'Application("iTunes").currentTrack.name()'
}

artist=`escape_uri "$(itunes_artist)"`
name=`escape_uri "$(itunes_name)"`

lyrics_url="https://makeitpersonal.co/lyrics?artist=$artist&title=$name"

curl -s $lyrics_url | less
