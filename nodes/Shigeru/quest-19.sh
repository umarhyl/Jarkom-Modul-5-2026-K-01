#!/bin/bash

# Quest 19
if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

sysctl -w net.ipv4.ip_forward=1

iptables -F INPUT
iptables -F OUTPUT
iptables -F FORWARD
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT

iptables -A INPUT -s 10.64.4.83 -j DROP
iptables -A OUTPUT -d 10.64.4.83 -j DROP
iptables -A FORWARD -s 10.64.4.83 -j DROP
iptables -A FORWARD -d 10.64.4.83 -j DROP

iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -i eth0 -s 10.64.4.56/29 -p icmp --icmp-type echo-request -j ACCEPT
iptables -A FORWARD -i eth0 -j DROP

iptables -S
