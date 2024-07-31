#!/bin/bash

# Variables
BACKUP_DIR="/var/backups/postgresql"
DATE=$(date +"%d-%m-%Y")
BACKUP_FILE="$BACKUP_DIR/db_backup_$DATE.sql"

# Perform backup
sudo -u postgres pg_dumpall > $BACKUP_FILE

 