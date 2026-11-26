#!/bin/bash

# Test quest 13 (Unit-01 -> Magi-Balthasar 10.64.4.59, harus BERHASIL)
for port in 5000 5001; do
    echo "--- Unit-01 -> Balthasar port $port ---"
    echo "Test dari Unit-01 ke Balthasar port $port" | nc -w 2 10.64.4.59 $port
    echo "Exit code: $?"
done
