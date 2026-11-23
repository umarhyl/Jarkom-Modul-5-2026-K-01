#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

# to Gendou
auto eth0
iface eth0 inet static
    address 10.64.4.134
    netmask 255.255.255.252

# Switch-Hangar
auto eth1
iface eth1 inet static
    address 10.64.3.1
    netmask 255.255.255.128

# to Mari
auto eth2
iface eth2 inet static
    address 10.64.4.161
    netmask 255.255.255.252

# to Rei
auto eth3
iface eth3 inet static
    address 10.64.4.165
    netmask 255.255.255.252

# to Shinji
auto eth4
iface eth4 inet static
    address 10.64.4.169
    netmask 255.255.255.252

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.4.134/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.3.1/25 dev eth1
ip link set eth1 up
ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.4.161/30 dev eth2
ip link set eth2 up
ip addr flush dev eth3 2>/dev/null
ip addr add 10.64.4.165/30 dev eth3
ip link set eth3 up
ip addr flush dev eth4 2>/dev/null
ip addr add 10.64.4.169/30 dev eth4
ip link set eth4 up

sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

ip route replace default via 10.64.4.133
ip route replace 10.64.4.32/28 via 10.64.4.162
ip route replace 10.64.0.0/23 via 10.64.4.166
ip route replace 10.64.4.0/27 via 10.64.4.170

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
