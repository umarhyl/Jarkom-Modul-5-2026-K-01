#!/bin/bash

# Test quest 7
echo "Kirim ke Magi-Casper (Port 5000)..."
echo "Pesan dari Lilith ke Casper" | nc -w 2 10.64.4.58 5000

echo "Kirim ke Magi-Balthasar (Port 5000)..."
echo "Pesan dari Lilith ke Balthasar 5000" | nc -w 2 10.64.4.59 5000

echo "Kirim ke Magi-Balthasar (Port 5001)..."
echo "Pesan dari Lilith ke Balthasar 5001" | nc -w 2 10.64.4.59 5001

echo "Kirim ke Magi-Melchior (Port 5000)..."
echo "Pesan dari Lilith ke Melchior 5000" | nc -w 2 10.64.4.60 5000
