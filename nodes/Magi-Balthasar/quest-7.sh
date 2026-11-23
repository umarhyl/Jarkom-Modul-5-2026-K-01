#!/bin/bash

# Quest 7
apt-get update && apt-get install -y netcat-traditional iptables
pkill -f "nc -l -p 5000" 2>/dev/null
pkill -f "nc -l -p 5001" 2>/dev/null
nc -l -p 5000 -k &
nc -l -p 5001 -k &
echo "Listener TCP 5000 dan 5001 Magi-Balthasar aktif di background!"
