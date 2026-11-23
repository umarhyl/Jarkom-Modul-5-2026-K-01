#!/bin/bash

# Quest 7
apt-get update && apt-get install -y netcat-traditional iptables
pkill -f "nc -l -p 5000" 2>/dev/null
nc -l -p 5000 -k &
echo "Listener TCP 5000 Magi-Casper aktif di background!"
