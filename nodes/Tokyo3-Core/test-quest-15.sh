#!/bin/bash

# Test soal 15
iptables -L INPUT -v -n
ping -i 0.1 -c 20 10.64.4.74
