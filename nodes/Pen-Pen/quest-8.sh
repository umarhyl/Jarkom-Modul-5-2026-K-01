#!/bin/bash

# Quest 8
apt-get update && apt-get install -y netcat-traditional
pkill -f "nc -l -p 80" 2>/dev/null

while true; do
    echo "Welcome to Pen-Pen" | nc -l -p 80
done &

echo "Service Port 80 Pen-Pen aktif di background!"
