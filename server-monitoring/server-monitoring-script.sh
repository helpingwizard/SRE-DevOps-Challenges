#!/bin/bash

# SMTP Configuration
#
RECIPIENT="vctanish7@gmail.com"
SUBJECT="System Health Report"

# Function to collect system health data
collect_data() {
    DISK_USAGE=$(df -h | awk 'NR==1 || $NF=="/"')
    MEMORY_USAGE=$(free -h | awk 'NR==1 || NR==2')
    CPU_USAGE=$(top -bn1 | grep "%Cpu" | awk '{print $2 " us, " $4 " sy, " $8 " id"}')
    RUNNING_SERVICES=$(systemctl list-units --type=service --state=running | head -n 10)

    echo "<html>" > /tmp/system_report.html
    echo "<head><title>System Health Report</title></head>" >> /tmp/system_report.html
    echo "<body><h1>System Health Report</h1>" >> /tmp/system_report.html
    echo "<h2>Disk Usage</h2><pre>$DISK_USAGE</pre>" >> /tmp/system_report.html
    echo "<h2>Memory Usage</h2><pre>$MEMORY_USAGE</pre>" >> /tmp/system_report.html
    echo "<h2>CPU Usage</h2><p>CPU Usage: $CPU_USAGE</p>" >> /tmp/system_report.html
    echo "<h2>Running Services</h2><pre>$RUNNING_SERVICES</pre>" >> /tmp/system_report.html
    echo "</body></html>" >> /tmp/system_report.html
}

# Function to send the email
send_email() {
    #

    # Send email with the report as content
    sendmail -v $RECIPIENT <<EOF
Subject: $SUBJECT
Content-Type: text/html

$(cat /tmp/system_report.html)
EOF
}

# Main script execution
collect_data
send_email

# Schedule with cron if needed (every 4 hours):
# 0 */4 * * * /path/to/this_script.sh
