#!/bin/bash
# Quest 15

# Pastikan iptables sudah terpasang
if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

# Reset chain INPUT 
iptables -F INPUT
iptables -P INPUT ACCEPT

# Izinkan loopback
iptables -A INPUT -i lo -j ACCEPT

# Batasi ping masuk (echo-request) maksimal 5/detik 
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/second --limit-burst 5 -j ACCEPT

# Buang kelebihan ping masuk
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Izinkan balasan koneksi keluar (termasuk echo-reply saat Tokyo3-Core ping node lain)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

echo "=== Konfigurasi Firewall Quest 15 (Tokyo3-Core) ==="
iptables -L INPUT -v -n