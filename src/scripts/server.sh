#!/bin/bash

set -e

# locale-gen UTF-8

apt-get update && apt-get upgrade --yes

# Essentials
apt-get install --yes build-essential git vim curl htop autoconf bison libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev

# Node
wget -qO- https://deb.nodesource.com/setup_4.x | sudo bash -
apt-get install --yes nodejs

# Workflow
cp /root/dotfiles/src/.aliases /root/
echo '. /root/.aliases' >> /root/.bashrc

cp /root/dotfiles/src/.gitconfig /root/
chmod +x /root/dotfiles/bootstrap/vim.sh
/root/dotfiles/bootstrap/vim.sh

# rbenv, ruby, rails, gems
# curl https://raw.githubusercontent.com/fesplugas/rbenv-installer/master/bin/rbenv-installer | bash
# rbenv install 2.2.3
# gem install bundler

# Passenger
