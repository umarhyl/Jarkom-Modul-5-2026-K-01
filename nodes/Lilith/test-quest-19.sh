#!/bin/bash

# Test quest 19: Nyalakan listener TCP 9000 di Lilith (tujuan uji dari Zeruel & Armisael)
pkill -f "nc -l -p 9000" 2>/dev/null
while true; do nc -l -p 9000; done &
echo "Listener TCP 9000 Lilith aktif di background!"
