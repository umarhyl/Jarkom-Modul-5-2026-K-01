#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
    address 10.64.4.60
    netmask 255.255.255.248
    gateway 10.64.4.57
EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.4.60/29 dev eth0
ip link set eth0 up
ip route replace default via 10.64.4.57

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
