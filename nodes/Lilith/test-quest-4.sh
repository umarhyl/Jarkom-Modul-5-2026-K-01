#!/bin/bash

# Test quest 4
echo "1. Ping Internet (8.8.8.8)..."
ping -c 3 8.8.8.8

echo "2. Ping Domain deb.debian.org..."
ping -c 3 deb.debian.org
