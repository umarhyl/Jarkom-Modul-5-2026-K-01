#!/bin/bash

# Quest 16

if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

# Reset chain INPUT agar tidak ada rule dobel
iptables -F INPUT
iptables -P INPUT ACCEPT

# Izinkan loopback
iptables -A INPUT -i lo -j ACCEPT

iptables -A INPUT -s 10.64.4.51 -p tcp -m multiport --dports 22,23,3306 -j LOG --log-prefix "SCAN-NERV: " --log-level 4
iptables -A INPUT -s 10.64.4.51 -p tcp -m multiport --dports 22,23,3306 -j REJECT --reject-with tcp-reset

# Batasi ping masuk maksimal 5/detik
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/second --limit-burst 5 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -L INPUT -v -n