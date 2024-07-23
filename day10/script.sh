#!/bin/bash

### Configuration Variable ###
REPORT_FILE="system_report_$(date +"%d-%m-%Y").log"
EMAIL_ADDRESS="admin@example.com"
CRITICAL_CPU_THRESHOLD=80
CRITICAL_MEM_THRESHOLD=90

echo "" > ${REPORT_FILE}

send_mail() {
    local subject=$1
    local body=$2
    echo "$body" | mail -s "$subject" "$EMAIL_ADDRESS"
}
monitor_system_metrices() {
    echo "=== System Metrices ===" >> ${REPORT_FILE}
    echo "--- CPU and Memory Usage ---" >> ${REPORT_FILE}
    top -bn1 | grep "Cpu(s)" | cut -d "," -f4 | cut -d " " -f2 | awk '{print "CPU usage : " 100 - $1 "%"}' >> ${REPORT_FILE}
    free -m | grep "Mem" | awk '{print "Memory Usage : " $3/$2 * 100.0 "%"}' >> ${REPORT_FILE}
    echo "" >> ${REPORT_FILE}

    echo "--- Disk Usage ---" >> ${REPORT_FILE}
    df -h >> ${REPORT_FILE}
    echo "" >> ${REPORT_FILE}

    echo "--- Network Statistics ---" >> ${REPORT_FILE}
    netstat -s >> ${REPORT_FILE}
    echo "" >> ${REPORT_FILE}

    echo "--- Top Processes ---" >> ${REPORT_FILE}
    ps -eo pid,ppid,cmd,%mem,%cpu | head -n 5 >> ${REPORT_FILE}

    echo "--- Log Analysis ---" >> ${REPORT_FILE}
    less /var/log/syslog | grep -iE 'error|critical' | head -n 10 >> ${REPORT_FILE}
    echo "" >> ${REPORT_FILE}
}

health_check() {
    echo "=== Health Checks ===" >> $REPORT_FILE
    echo "--- Service Status ---" >> $REPORT_FILE
    systemctl status apache2 >> $REPORT_FILE
    systemctl status apache2 >> $REPORT_FILE
    echo "" >> ${REPORT_FILE}

    echo "--- Check Connectivity ---" >> $REPORT_FILE
    ping -c 3 google.com >> $REPORT_FILE
    echo "" >> ${REPORT_FILE}
}

alert(){
    local cpu_usage=$(top -bn1 | grep "Cpu(s)" | cut -d "," -f4 | cut -d " " -f2)
    local mem_usage=$(free -m | grep "Mem")

    echo $cpu_usage

    if (( $(echo "$cpu_usage >= $CRITICAL_CPU_THRESHOLD" | bc -l) )); then
        send_email "CRITICAL: High CPU Usage Alert" "Current CPU usage is $cpu_usage%"
    fi

    if (( $(echo "$mem_usage >= $CRITICAL_MEM_THRESHOLD" | bc -l) )); then
        send_email "CRITICAL: High Memory Usage Alert" "Current Memory usage is $mem_usage%"
    fi
        
}

monitor_system_metrices
health_check
alert