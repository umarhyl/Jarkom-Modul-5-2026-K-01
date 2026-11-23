#!/bin/bash

# Quest 9
echo "=== Routing Table Sebelum Perbaikan ==="
ip route show

echo "Memulihkan rute default ke Gendou..."
ip route replace default via 10.64.4.113 dev eth0

echo "Memulihkan rute ke Makoto (Switch-Radar)..."
ip route replace 10.64.4.88/29 via 10.64.4.146 dev eth2

echo "=== Routing Table Setelah Perbaikan ==="
ip route show
