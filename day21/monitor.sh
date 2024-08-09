#!/bin/bash

REPORT_FILE="system_report_$(date +"%d-%m-%Y").log"
monitor_system_metrices() {
    echo "=== System Metrices ===" >> ${REPORT_FILE}
    echo "--- CPU and Memory Usage ---" >> ${REPORT_FILE}
    top -bn1 | grep "Cpu(s)" | cut -d "," -f4 | cut -d " " -f2 | awk '{print "CPU usage : " 100 - $1 "%"}' >> ${REPORT_FILE}
    free -m | grep "Mem" | awk '{print "Memory Usage : " $3/$2 * 100.0 "%"}' >> ${REPORT_FILE}
    echo "" >> ${REPORT_FILE}

    echo "--- Disk Usage ---" >> ${REPORT_FILE}
    df -h >> ${REPORT_FILE}
    echo "" >> ${REPORT_FILE}
}

monitor_system_metrices