#!/bin/bash

# Test quest 19
ping -c 2 -W 2 8.8.8.8
nc -zv -w 2 8.8.8.8 53
echo $?

ping -c 2 -W 2 10.64.4.74
nc -zv -w 2 10.64.4.74 9000
echo $?
