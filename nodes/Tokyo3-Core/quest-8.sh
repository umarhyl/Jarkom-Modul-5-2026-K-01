#!/bin/bash

# Quest 8
apt-get update && apt-get install -y netcat-traditional
pkill -f "nc -l -p 80" 2>/dev/null
pkill -f "nc -l -p 8080" 2>/dev/null

while true; do
    echo "Welcome to Tokyo3-Core" | nc -l -p 80
done &

while true; do
    echo "syifa imutz" | nc -l -p 8080
done &

echo "Service Port 80 & 8080 Tokyo3-Core aktif di background!"
