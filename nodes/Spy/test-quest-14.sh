#!/bin/bash

# Test soal 14
ping -c 3 -W 2 10.64.3.194
nc -w 2 10.64.3.194 80
