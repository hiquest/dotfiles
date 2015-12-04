#!/bin/bash

set -e

# locale-gen UTF-8

apt-get update && apt-get upgrade --yes

# Essentials
apt-get install --yes build-essential git vim curl htop autoconf bison libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev

# Node
wget -qO- https://deb.nodesource.com/setup_4.x | sudo bash -
apt-get install --yes nodejs
