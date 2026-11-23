#!/bin/bash

# Quest 12
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -F INPUT

# Izinkan loopback
iptables -A INPUT -i lo -j ACCEPT

# Izinkan established & related (kunci agar apt-get & ping keluar sukses)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Izinkan TCP 5000
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT

# Tolak ping masuk (tujuan hardening soal 11 tetap terjaga)
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

iptables -S
