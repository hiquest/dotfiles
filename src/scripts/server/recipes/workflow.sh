#!/bin/bash

set -e

cd /root/

# Generate ssh key
ssh-keygen -f /root/.ssh/id_rsa -t rsa -b 4096 -C "janis.sci@gmail.com" -N ''

# Clone repo
git clone https://github.com/hiquest/dotfiles.git

# Aliases
cp /root/dotfiles/src/.aliases /root/
echo '. /root/.aliases' >> /root/.bashrc

# Gitconfig
cp /root/dotfiles/src/.gitconfig /root/

# Setup vim
chmod +x /root/dotfiles/bootstrap/vim.sh
/root/dotfiles/bootstrap/vim.sh
