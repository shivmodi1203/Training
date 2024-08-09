#!/bin/bash

# Set log directory and rotation settings
LOG_DIR=/var/log/myapp/
MAX_LOG_SIZE=100M
MAX_LOG_AGE=30

# Set compression tool and report file
COMPRESS_TOOL=gzip
REPORT_FILE=log_management_report.txt

# Function to rotate logs
rotate_logs() {
  for log in $(find $LOG_DIR -type f -size +$MAX_LOG_SIZE); do
    log_name=$(basename $log)
    log_dir=$(dirname $log)
    new_log_name=$log_dir/${log_name}.1
    mv $log $new_log_name
    echo "Rotated log: $log_name" >> $REPORT_FILE
  done
}

# Function to compress old logs
compress_logs() {
  for log in $(find $LOG_DIR -type f -name "*.1" -mtime +$MAX_LOG_AGE); do
    log_name=$(basename $log)
    log_dir=$(dirname $log)
    compressed_log_name=$log_dir/${log_name}.gz
    $COMPRESS_TOOL $log
    rm $log
    echo "Compressed log: $log_name" >> $REPORT_FILE
  done
}

# Function to delete old logs
delete_logs() {
  for log in $(find $LOG_DIR -type f -name "*.gz" -mtime +$MAX_LOG_AGE); do
    log_name=$(basename $log)
    rm $log
    echo "Deleted log: $log_name" >> $REPORT_FILE
  done
}

# Main script
echo "Log Management Report" > $REPORT_FILE
echo "---------------------" >> $REPORT_FILE
rotate_logs
compress_logs
delete_logs
echo "Log management tasks completed." >> $REPORT_FILE