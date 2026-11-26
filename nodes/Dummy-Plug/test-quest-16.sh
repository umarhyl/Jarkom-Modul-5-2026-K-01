#!/bin/bash

# Test quest 16
for port in 22 23 3306; do
    echo "--- Mencoba port $port ---"
    START=$(date +%s%3N)
    nc -zv -w 2 10.64.4.106 $port 2>&1 || nc -w 2 10.64.4.106 $port 2>&1
    EXIT_CODE=$?
    END=$(date +%s%3N)
    echo "Exit code: $EXIT_CODE | Durasi: $((END - START)) ms"
done

echo ""
echo "--- Port 80 ---"
nc -w 2 10.64.4.106 80

echo "--- Port 8080 ---"
nc -w 2 10.64.4.106 8080