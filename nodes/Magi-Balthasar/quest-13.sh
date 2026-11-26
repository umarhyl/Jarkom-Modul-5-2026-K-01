#!/bin/bash

# Quest 13: Brankas Balthasar
# Hanya Magi-Casper dan semua Pilot (Unit-01, Unit-02, Unit-00, Sachiel)
# yang boleh mengakses TCP 5000 & 5001. Lainnya langsung ditolak (tcp-reset).

if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

# Pastikan listener TCP 5000 & 5001 aktif
pgrep -f "nc -l -p 5000" >/dev/null 2>&1 || nc -l -p 5000 -k &
pgrep -f "nc -l -p 5001" >/dev/null 2>&1 || nc -l -p 5001 -k &

# Reset chain INPUT agar idempoten dan lalu lintas lain tetap berjalan
iptables -F INPUT
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT

# Izinkan loopback & balasan koneksi yang diinisiasi Balthasar
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Izinkan HANYA Casper (10.64.4.58) dan semua Pilot (Unit-01/02/00, Sachiel)
ALLOWED_IPS="10.64.4.58,10.64.4.66,10.64.4.67,10.64.4.68,10.64.3.130"
iptables -A INPUT -s $ALLOWED_IPS -p tcp -m multiport --dports 5000,5001 -j ACCEPT

# Tolak seketika semua node lain (termasuk satu switch) di TCP 5000 & 5001
iptables -A INPUT -p tcp -m multiport --dports 5000,5001 -j REJECT --reject-with tcp-reset

echo "=== iptables Magi-Balthasar (INPUT) ==="
iptables -S INPUT

echo "=== Uji ping keluar dari Balthasar ke 8.8.8.8 ==="
ping -c 3 8.8.8.8
