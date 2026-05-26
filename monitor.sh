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

echo ""
echo "Memory Usage:"
free -m

echo ""
echo "Disk Usage:"
df -h

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
