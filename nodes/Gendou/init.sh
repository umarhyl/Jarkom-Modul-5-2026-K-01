#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp

# Switch-Cmd
auto eth1
iface eth1 inet static
    address 10.64.4.105
    netmask 255.255.255.252

# to Fuyutsuki
auto eth2
iface eth2 inet static
    address 10.64.4.109
    netmask 255.255.255.252

# to Shigeru
auto eth3
iface eth3 inet static
    address 10.64.4.113
    netmask 255.255.255.252

# to Misato
auto eth4
iface eth4 inet static
    address 10.64.4.117
    netmask 255.255.255.252

# to Kaji
auto eth5
iface eth5 inet static
    address 10.64.4.121
    netmask 255.255.255.252

# to Asuka
auto eth6
iface eth6 inet static
    address 10.64.4.125
    netmask 255.255.255.252

# to Hikari
auto eth7
iface eth7 inet static
    address 10.64.4.129
    netmask 255.255.255.252

# to Yui
auto eth8
iface eth8 inet static
    address 10.64.4.133
    netmask 255.255.255.252

EOF

udhcpc -i eth0 -n -q 2>/dev/null || dhclient eth0 2>/dev/null &

ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.4.105/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.4.109/30 dev eth2
ip link set eth2 up
ip addr flush dev eth3 2>/dev/null
ip addr add 10.64.4.113/30 dev eth3
ip link set eth3 up
ip addr flush dev eth4 2>/dev/null
ip addr add 10.64.4.117/30 dev eth4
ip link set eth4 up
ip addr flush dev eth5 2>/dev/null
ip addr add 10.64.4.121/30 dev eth5
ip link set eth5 up
ip addr flush dev eth6 2>/dev/null
ip addr add 10.64.4.125/30 dev eth6
ip link set eth6 up
ip addr flush dev eth7 2>/dev/null
ip addr add 10.64.4.129/30 dev eth7
ip link set eth7 up
ip addr flush dev eth8 2>/dev/null
ip addr add 10.64.4.133/30 dev eth8
ip link set eth8 up

sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

ip route replace 10.64.4.56/29 via 10.64.4.110
ip route replace 10.64.4.136/30 via 10.64.4.110
ip route replace 10.64.3.192/27 via 10.64.4.110
ip route replace 10.64.4.140/30 via 10.64.4.110
ip route replace 10.64.4.72/29 via 10.64.4.110
ip route replace 10.64.4.80/29 via 10.64.4.114
ip route replace 10.64.4.144/30 via 10.64.4.114
ip route replace 10.64.4.88/29 via 10.64.4.114
ip route replace 10.64.4.64/29 via 10.64.4.118
ip route replace 10.64.4.100/30 via 10.64.4.122
ip route replace 10.64.4.96/30 via 10.64.4.126
ip route replace 10.64.4.148/30 via 10.64.4.126
ip route replace 10.64.3.128/26 via 10.64.4.126
ip route replace 10.64.4.152/30 via 10.64.4.126
ip route replace 10.64.4.48/29 via 10.64.4.126
ip route replace 10.64.2.0/24 via 10.64.4.130
ip route replace 10.64.4.156/30 via 10.64.4.130
ip route replace 10.64.3.224/27 via 10.64.4.130
ip route replace 10.64.3.0/25 via 10.64.4.134
ip route replace 10.64.4.160/30 via 10.64.4.134
ip route replace 10.64.4.32/28 via 10.64.4.134
ip route replace 10.64.4.164/30 via 10.64.4.134
ip route replace 10.64.0.0/23 via 10.64.4.134
ip route replace 10.64.4.168/30 via 10.64.4.134
ip route replace 10.64.4.0/27 via 10.64.4.134

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
