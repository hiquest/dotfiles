#!/bin/bash

set -e

./recipes/essentials.sh
./recipes/workflow.sh
./recipes/rbenv.sh
./recipes/ruby.sh
./recipes/passenger_nginx.sh
