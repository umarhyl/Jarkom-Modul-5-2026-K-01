#!/bin/bash

# Quest 12
# Bersihkan aturan lama di INPUT dan OUTPUT (hapus blokir port 53 DNS)
iptables -F INPUT
iptables -F OUTPUT

# Set Default Policy: INPUT DROP, FORWARD DROP, OUTPUT ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Izinkan Loopback
iptables -A INPUT -i lo -j ACCEPT

# Izinkan paket balasan (ESTABLISHED, RELATED)
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Buka port 5000 untuk service superkomputer Casper (agar Unit-00 bisa connect)
iptables -A INPUT -p tcp --dport 5000 -j ACCEPT

# Tolak incoming ICMP echo-request (Tujuan Soal 11: Casper tetap jadi hantu!)
iptables -A INPUT -p icmp --icmp-type echo-request -j DROP

# Pastikan DNS Nameserver aktif
cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF

# Pastikan background listener port 5000 tetap hidup
if ! pgrep -f "nc -l -p 5000" > /dev/null; then
    nc -l -p 5000 -k &
fi

echo "--- iptables di Casper ---"
iptables -S
