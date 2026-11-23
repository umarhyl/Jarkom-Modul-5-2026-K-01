#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

# to Gendou
auto eth0
iface eth0 inet static
    address 10.64.4.126
    netmask 255.255.255.252

# Switch-Archive
auto eth1
iface eth1 inet static
    address 10.64.4.97
    netmask 255.255.255.252

# to Kensuke
auto eth2
iface eth2 inet static
    address 10.64.4.149
    netmask 255.255.255.252

# to Ritsuko
auto eth3
iface eth3 inet static
    address 10.64.4.153
    netmask 255.255.255.252

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.4.126/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.4.97/30 dev eth1
ip link set eth1 up
ip addr flush dev eth2 2>/dev/null
ip addr add 10.64.4.149/30 dev eth2
ip link set eth2 up
ip addr flush dev eth3 2>/dev/null
ip addr add 10.64.4.153/30 dev eth3
ip link set eth3 up

sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

ip route replace default via 10.64.4.125
ip route replace 10.64.3.128/26 via 10.64.4.150
ip route replace 10.64.4.48/29 via 10.64.4.154

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
