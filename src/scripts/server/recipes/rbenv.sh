#!/bin/bash

set -e

git clone https://github.com/sstephenson/rbenv.git /root/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> /root/.profile
source /root/.profile
echo 'eval "$(rbenv init -)"' >> /root/.profile
source /root/.profile

# ruby-build
git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
