#!/bin/bash

# Test soal 15
echo "Uji Ping Rapat"
ping -i 0.1 -c 50 10.64.4.106
echo ""
echo "Menunggu 3 detik agar kuota limit terisi ulang..."
sleep 3
echo ""
echo "Uji Ping Normal"
ping -c 5 10.64.4.106
