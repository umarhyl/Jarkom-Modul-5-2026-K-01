#!/bin/bash

# Quest 4 & 5

# IP Forwarding
sysctl -w net.ipv4.ip_forward=1

# Set Default Policy: INPUT DROP, FORWARD DROP, OUTPUT ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Flush Rules Lama
iptables -F INPUT
iptables -F FORWARD

# Izinkan Loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A FORWARD -i lo -j ACCEPT

# Izinkan DHCP Client dari sisi NAT1 (eth0)
iptables -A INPUT -i eth0 -p udp --sport 67 --dport 68 -j ACCEPT

# Aturan (a): Balasan koneksi yang sudah ada (ESTABLISHED, RELATED)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Aturan (b): Traffic dari jaringan internal ke internet
iptables -A FORWARD -s 10.64.0.0/19 -o eth0 -j ACCEPT

# Aturan (c): Traffic antar-LAN internal
iptables -A FORWARD -s 10.64.0.0/19 -d 10.64.0.0/19 -j ACCEPT

# Aturan (d): Traffic dari jaringan internal ke Gendo sendiri
iptables -A INPUT -s 10.64.0.0/19 -j ACCEPT

# NAT Masquerade (HANYA prefix internal yang keluar lewat eth0 ke NAT1)
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -o eth0 -s 10.64.0.0/19 -j MASQUERADE

# DNS Nameserver
cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF

echo "Konfigurasi Firewall & NAT Gendo Selesai!"
iptables -S
