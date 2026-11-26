#!/bin/bash

# Quest 17

# Pastikan iptables dan conntrack sudah terpasang
if ! command -v iptables >/dev/null 2>&1 || ! command -v conntrack >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables conntrack
fi

sysctl -w net.ipv4.ip_forward=1

# Bersihkan tabel NAT lama
iptables -t nat -F PREROUTING
iptables -t nat -F POSTROUTING

iptables -t nat -A PREROUTING -s 10.64.4.58 -d 10.64.4.82 -p tcp -j DNAT --to-destination 10.64.3.194
iptables -t nat -L PREROUTING -v -n
