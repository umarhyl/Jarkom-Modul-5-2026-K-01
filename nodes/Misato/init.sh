#!/bin/bash
# Configuration script for Router: Misato

# 1. Setup persistent network interfaces
cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

# to Gendou
auto eth0
iface eth0 inet static
    address 10.64.4.118
    netmask 255.255.255.252

# Switch-Cage
auto eth1
iface eth1 inet static
    address 10.64.4.65
    netmask 255.255.255.248

EOF

# 2. Apply IP addresses immediately
ip addr flush dev eth0 2>/dev/null
ip addr add 10.64.4.118/30 dev eth0
ip link set eth0 up
ip addr flush dev eth1 2>/dev/null
ip addr add 10.64.4.65/29 dev eth1
ip link set eth1 up

# 3. Enable IP Forwarding
sysctl -w net.ipv4.ip_forward=1
echo 1 > /proc/sys/net/ipv4/ip_forward

# 4. Static Routing
ip route replace default via 10.64.4.117

# 5. DNS Resolution
cat <<EOF > /etc/resolv.conf
nameserver 192.168.122.1
nameserver 8.8.8.8
EOF
