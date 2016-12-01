#!/bin/bash
set -e

curl http://api.fixer.io/latest\?base\=USD\&symbols\=RUB 2> /dev/null \
  | python -m json.tool \
  | grep RUB \
  | awk '{print $2}'
