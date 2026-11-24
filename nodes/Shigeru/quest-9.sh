#!/bin/bash

# Quest 9
sysctl -w net.ipv4.ip_forward=1

while ip rule del priority 90 2>/dev/null; do :; done
while ip rule del lookup 100 2>/dev/null; do :; done
ip route flush table 100 2>/dev/null

ip route del blackhole 10.64.4.72/29 2>/dev/null
ip route replace default via 10.64.4.113 dev eth0
ip route replace 10.64.4.88/29 via 10.64.4.146 dev eth2

sysctl net.ipv4.ip_forward

echo "--- IP Rules (Policy Routing) ---"
ip rule show

echo "--- Routing Table Main ---"
ip route show
