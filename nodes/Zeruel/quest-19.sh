#!/bin/bash

# Quest 19
if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

iptables -F INPUT
iptables -F OUTPUT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

iptables -A INPUT -s 10.64.4.83 -j DROP
iptables -A OUTPUT -d 10.64.4.83 -j DROP

iptables -S

pkill -f "nc -l -p 9000" 2>/dev/null
while true; do nc -l -p 9000; done &