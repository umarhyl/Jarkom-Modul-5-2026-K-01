#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

# to Asuka
auto eth0
iface eth0 inet static
    address 10.64.4.154
    netmask 255.255.255.252

# Switch-Lab
auto eth1
iface eth1 inet static
    address 10.64.4.49
    netmask 255.255.255.248

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.4.154/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.4.49/29 dev eth1
ip link set eth1 up

sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

ip route replace default via 10.64.4.153

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
