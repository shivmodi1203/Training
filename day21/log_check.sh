#!/bin/bash

LOG_FILE="/var/log/syslog"
KEYWORDS=("out of memory" "failed" "error" "panic")

# Parse logs for issues
parse_logs() {
  for keyword in "${KEYWORDS[@]}"; do
    echo "Searching for $keyword in logs..."
    grep -i "$keyword" "$LOG_FILE" >> /var/log/troubleshooting.log
  done
}

# Troubleshooting guide
generate_troubleshooting_guide() {
  echo "Troubleshooting Guide" > /var/log/troubleshooting_guide.txt
  echo "1. Out of memory: Check system resources and consider adding swap space." >> /var/log/troubleshooting_guide.txt
  echo "2. Failed service starts: Ensure the service configuration is correct and dependencies are met." >> /var/log/troubleshooting_guide.txt
  echo "3. General errors: Check the application configuration and logs for specific error messages." >> /var/log/troubleshooting_guide.txt
}

# Main function
main() {
  parse_logs
  generate_troubleshooting_guide
}

main 2>&1 | sudo tee -a /var/log/log_checking.log
