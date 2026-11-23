#!/bin/bash

# Quest 10
iptables -F
iptables -t nat -F
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

sysctl -w net.ipv4.ip_forward=1

ip route replace default via 10.64.4.117 dev eth0

ip route show
