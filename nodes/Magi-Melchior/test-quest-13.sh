#!/bin/bash

# Test quest 13 (Magi-Melchior -> Magi-Balthasar 10.64.4.59, satu switch, harus DITOLAK SEKETIKA)
for port in 5000 5001; do
    echo "--- Melchior -> Balthasar port $port ---"
    START=$(date +%s%3N)
    nc -zv -w 2 10.64.4.59 $port 2>&1
    EXIT_CODE=$?
    END=$(date +%s%3N)
    echo "Exit code: $EXIT_CODE | Durasi: $((END - START)) ms"
done
