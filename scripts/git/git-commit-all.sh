#!/bin/bash

# Add and commit all files

set -e

git add . && git commit -m $@
