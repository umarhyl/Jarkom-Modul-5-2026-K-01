#!/bin/bash

# Test quest 8
echo "Uji Pen-Pen Port 80"
nc -w 2 10.64.3.194 80

echo "Uji Tokyo3-Core Port 80"
nc -w 2 10.64.4.106 80

echo "Uji Tokyo3-Core Port 8080"
nc -w 2 10.64.4.106 8080

echo "Uji Port 22 Tokyo3-Core"
nc -w 2 10.64.4.106 22
