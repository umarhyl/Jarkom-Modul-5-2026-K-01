#!/bin/bash

# Quest 18
if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

sysctl -w net.ipv4.ip_forward=1

iptables -F FORWARD
iptables -P FORWARD ACCEPT

iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -s 10.64.4.56/29 -p icmp --icmp-type echo-request -j ACCEPT
iptables -A FORWARD -i eth0 -j DROP

iptables -L FORWARD -v -n
