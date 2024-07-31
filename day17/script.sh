#!/bin/bash

# Set variables
DATABASE_NAME=database1
USER=root
BACKUP_DIR=/var/backups/psql
DATE=$(date +"%d-%m-%Y")

# Create backup file name
BACKUP_FILE="${BACKUP_DIR}/${DATABASE_NAME}_${DATE}.sql"

# Dump database to backup file
# mysqldump -u myuser -p ${database_password} ${DATABASE_NAME} > ${BACKUP_FILE}
pg_dump -U "$USER" "$DBNAME"  > ${BACKUP_FILE}

# Compress backup file
gzip ${BACKUP_FILE}

 