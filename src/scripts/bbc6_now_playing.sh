#!/bin/bash

JSON_OUT=$(curl --silent http://polling.bbc.co.uk/radio/realtime/bbc_6music.json | python -m json.tool)
artist=$(echo "$JSON_OUT" | grep "artist" | sed 's/"artist": "//' | head -n 1 | sed 's/",$//' | sed 's/ \{1,\}/ /g')
title=$(echo "$JSON_OUT" | grep "title" | sed 's/"title": "//' | head -n 1 | sed 's/",$//' | sed 's/ \{1,\}/ /g')

echo "$artist — $title"
