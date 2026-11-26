#!/bin/bash

# Test quest 17
echo "Kirim pesan TCP ke IP Zeruel (10.64.4.82) port 9000"
echo "Pesan rahasia dari Magi-Casper untuk Zeruel" | nc -w 2 10.64.4.82 9000
echo "Exit code nc: $?"

echo ""
echo "Uji Ping ke Zeruel (10.64.4.82)"
ping -c 3 10.64.4.82
