#!/bin/bash

apt-get install iptables

# Variabel jadwal dalam UTC (WIB - 7 jam)
PILOT_START="01:00"
PILOT_STOP="09:00"
PILOT_DAYS="Mon,Tue,Wed,Thu,Fri"

STAF_START="10:00"
STAF_STOP="16:00"

# Pastikan iptables terpasang
if ! command -v iptables >/dev/null 2>&1; then
    apt-get update && apt-get install -y iptables
fi

# Reset chain INPUT
iptables -F INPUT
iptables -P INPUT ACCEPT

# Izinkan loopback & koneksi yang sudah terbentuk
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Daftar IP berdasarkan VLSM K-01
PILOT_IPS="10.64.4.66,10.64.4.67,10.64.4.68,10.64.3.130"
STAF_IPS="10.64.4.74,10.64.4.75"
DUMMY_IPS="10.64.4.51,10.64.4.50,10.64.4.102"

# Terduga Dummy System: selalu ditolak (ping & TCP 80)
iptables -A INPUT -s $DUMMY_IPS -p icmp --icmp-type echo-request -j DROP
iptables -A INPUT -s $DUMMY_IPS -p tcp --dport 80 -j REJECT --reject-with tcp-reset

# Pilot: hanya boleh sesuai jam & hari (UTC), di luar itu tolak
iptables -A INPUT -s $PILOT_IPS -p icmp --icmp-type echo-request -m time --timestart $PILOT_START --timestop $PILOT_STOP --weekdays $PILOT_DAYS --utc -j ACCEPT
iptables -A INPUT -s $PILOT_IPS -p tcp --dport 80 -m time --timestart $PILOT_START --timestop $PILOT_STOP --weekdays $PILOT_DAYS --utc -j ACCEPT
iptables -A INPUT -s $PILOT_IPS -p icmp --icmp-type echo-request -j DROP
iptables -A INPUT -s $PILOT_IPS -p tcp --dport 80 -j REJECT --reject-with tcp-reset

# Staf Geofront: hanya boleh sesuai jam (UTC, tiap hari), di luar itu tolak
iptables -A INPUT -s $STAF_IPS -p icmp --icmp-type echo-request -m time --timestart $STAF_START --timestop $STAF_STOP --utc -j ACCEPT
iptables -A INPUT -s $STAF_IPS -p tcp --dport 80 -m time --timestart $STAF_START --timestop $STAF_STOP --utc -j ACCEPT
iptables -A INPUT -s $STAF_IPS -p icmp --icmp-type echo-request -j DROP
iptables -A INPUT -s $STAF_IPS -p tcp --dport 80 -j REJECT --reject-with tcp-reset

# sudah lolos karena policy INPUT ACCEPT
echo "--- iptables Pen-Pen (Jam UTC sekarang: $(date -u +%H:%M\ %a)) ---"
iptables -S INPUT