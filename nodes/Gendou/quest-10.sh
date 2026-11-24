#!/bin/bash

# Quest 10
iptables -t nat -F POSTROUTING
iptables -t nat -A POSTROUTING -o eth0 -s 10.64.0.0/19 -j MASQUERADE

echo "=== Verifikasi Tabel NAT Gendou ==="
iptables -t nat -L -v -n
