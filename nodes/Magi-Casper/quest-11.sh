#!/bin/bash

# Quest 11
iptables -F INPUT

# Loopback
iptables -A INPUT -i lo -j ACCEPT

# Balasan koneksi yang diinisiasi Casper (ESTABLISHED, RELATED)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Layanan TCP 5000 tetap buka
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT

# Blokir semua incoming ICMP echo request (ping dari luar)
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

iptables -S
