#!/bin/bash

echo "=============================="
echo " Linux Server Monitoring Tool "
echo "=============================="

echo ""
echo "System Uptime:"
uptime

echo ""
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)"

# Extract CPU usage (user + system) as integer
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
cpu_usage=${cpu_usage%.*}   # strip decimals

echo ""
echo "Memory Usage:"
free -m

echo ""
echo "Disk Usage:"
df -h

# Extract root disk usage percentage
disk_usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

echo ""
echo "Docker Status:"
sudo systemctl status docker | grep Active

echo ""
echo "Running Containers:"
sudo docker ps

echo ""
echo "Logged-in Users:"
who

echo ""
echo "Monitoring Completed."

# Threshold checks
if [ "$cpu_usage" -gt 80 ]; then
    echo "⚠️ CPU Usage High! ($cpu_usage%)"
else
    echo "✅ CPU Usage Normal ($cpu_usage%)"
fi

if [ "$disk_usage" -gt 80 ]; then
    echo "⚠️ Disk Space Warning! ($disk_usage%)"
else
    echo "✅ Disk Space Healthy ($disk_usage%)"
fi
# Optional: Memory check with else
mem_free=$(free -m | awk '/Mem:/ {print $4}')
if [ "$mem_free" -lt 100 ]; then
    echo "⚠️ Low Memory Warning! ($mem_free MB free)"
else
    echo "✅ Memory Usage Normal ($mem_free MB free)"
fi
