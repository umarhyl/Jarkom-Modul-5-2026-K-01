#!/bin/bash

# Test quest 6
echo "=== IP Interface Unit-01 ==="
ip -br a

echo "=== Ping ke Gateway Misato (10.64.4.65) ==="
ping -c 3 10.64.4.65
