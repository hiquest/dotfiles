#!/bin/bash

# Creates a database backup, compresses and puts it into Dropbox.
# Usage:
#   ./backupdb.sh <some_database>

MY_FILE=/backup-db/$1_$(date +%Y_%m_%d_%H_%M_%S)
sudo -u postgres pg_dump $1 -f $MY_FILE.sql
tar -czvf $MY_FILE.tar.gz $MY_FILE.sql
/root/dev/dropbox_uploader.sh upload $MY_FILE.tar.gz backup/$1/
