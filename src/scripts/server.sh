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
# Install our PGP key and add HTTPS support for APT
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
apt-get install -y apt-transport-https ca-certificates

# Add our APT repository
sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'
apt-get update
apt-get install -y nginx-extras passenger
