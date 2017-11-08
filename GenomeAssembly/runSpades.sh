#!/bin/bash
left=$1
right=$2

nice -n19 spades.py --pe1-1 $left --pe1-2 $right \
-o vibrioAssembly \
-m 50 \
-t 8 \
1>spades.log 2>spades.err &
