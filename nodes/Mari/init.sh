#!/bin/bash

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

# to Yui
auto eth0
iface eth0 inet static
    address 10.64.4.162
    netmask 255.255.255.252

# Switch-Dock
auto eth1
iface eth1 inet static
    address 10.64.4.33
    netmask 255.255.255.240

EOF

ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.4.162/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.4.33/28 dev eth1
ip link set eth1 up

sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

ip route replace default via 10.64.4.161

cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
