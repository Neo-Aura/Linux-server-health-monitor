
#!/bin/bash

LOG_DIR="$HOME/linux-server-health-monitor/logs"
LOG_FILE="$LOG_DIR/health-monitor.log"

mkdir -p "$LOG_DIR"
exec > >(tee -a "$LOG_FILE") 2>&1

set -e

MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

echo "===================================="
echo "       LINUX SERVER HEALTH MONITOR"
echo "===================================="

echo
echo "Check Time: $(date '+%Y-%m-%d %H:%M:%S %Z')"
echo "Hostname: $(hostname)"
echo "Current User: $(whoami)"
echo "System Uptime: $(uptime -p)"

echo
echo "CPU Load:"
uptime

CPU_CORES=$(nproc)
CPU_LOAD=$(awk '{print $1}' /proc/loadavg)
CPU_THRESHOLD=$(awk -v cores="$CPU_CORES" 'BEGIN {printf "%.2f", cores * 0.80}')

echo "CPU Cores: $CPU_CORES"
echo "1-Minute Load Average: $CPU_LOAD"
echo "CPU Load Alert Threshold: $CPU_THRESHOLD"

if awk -v cpu_load="$CPU_LOAD" -v threshold="$CPU_THRESHOLD" \
    'BEGIN {exit !(cpu_load >= threshold)}'; then
    echo "WARNING: CPU load is high compared with available CPU cores!"
else
    echo "OK: CPU load is within the configured threshold."
fi


echo
echo "Memory Usage:"
free -h

MEMORY_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

echo "Memory Usage: ${MEMORY_USAGE}%"
if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
    echo "WARNING: Memory usage is high!"
else
    echo "OK: Memory usage is normal."
fi

echo
echo "Disk Usage:"
df -h /

DISK_USAGE=$(df / | awk 'NR==2 {gsub(/%/, "", $5); print $5}')

echo "Root Disk Usage: ${DISK_USAGE}%"
if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    echo "WARNING: Root disk usage is high!"
else
    echo "OK: Root disk usage is normal."
fi

echo
echo "===================================="
echo "          CHECK COMPLETED"
echo "===================================="

