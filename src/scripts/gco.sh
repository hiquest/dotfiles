#!/bin/bash

set -e

# Checkout a branch by part of name
git branch \
  | grep $1 \
  | head -n 1 \
  | xargs git checkout
