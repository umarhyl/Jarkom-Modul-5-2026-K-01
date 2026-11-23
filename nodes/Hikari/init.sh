#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

# to Gendou
auto eth0
iface eth0 inet static
    address 10.64.4.130
    netmask 255.255.255.252

# Switch-Comm
auto eth1
iface eth1 inet static
    address 10.64.2.1
    netmask 255.255.255.0

# to Kaworu
auto eth2
iface eth2 inet static
    address 10.64.4.157
    netmask 255.255.255.252

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.4.130/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.2.1/24 dev eth1
ip link set eth1 up
ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.4.157/30 dev eth2
ip link set eth2 up

sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

ip route replace default via 10.64.4.129
ip route replace 10.64.3.224/27 via 10.64.4.158

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
