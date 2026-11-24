#!/bin/bash

# Test quest 7
echo "Pesan dari Lilith ke Casper" | nc -w 2 10.64.4.58 5000

echo "Pesan dari Lilith ke Balthasar port 5000" | nc -w 2 10.64.4.59 5000

echo "Pesan dari Lilith ke Balthasar port 5001" | nc -w 2 10.64.4.59 5001

echo "Pesan dari Lilith ke Melchior" | nc -w 2 10.64.4.60 5000
