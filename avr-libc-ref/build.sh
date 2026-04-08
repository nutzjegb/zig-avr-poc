#!/bin/sh

set -ex

avr-gcc -mmcu=avr64ea48 -Os -B -g../pack/gcc/dev/avr64ea48/ -isystem ../pack/include/ main.c
avr-objcopy -O ihex a.out a.hex
avr-objdump -dx a.out > a.dis
