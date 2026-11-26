#!/bin/bash

# Test quest 19
pkill -f "nc -l -p 9000" 2>/dev/null
while true; do nc -l -p 9000; done &

ping -c 2 -W 2 8.8.8.8
nc -zv -w 2 8.8.8.8 53
echo $?

ping -c 2 -W 2 10.64.4.74
nc -zv -w 2 10.64.4.74 9000
echo $?