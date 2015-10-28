#!/bin/bash

set -e

locale-gen UTF-8

apt-get update && apt-get upgrade

# Essentials
apt-get install build-essential git vim curl htop autoconf bison libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev

# Node
wget -qO- https://deb.nodesource.com/setup_4.x | sudo bash -
apt-get install --yes nodejs

# rbenv, ruby, rails, gems
curl https://raw.githubusercontent.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
