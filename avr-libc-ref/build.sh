#!/bin/sh

set -ex

avr-gcc -mmcu=avr64ea48 -Os -B -g../pack/gcc/dev/avr64ea48/ -isystem ../pack/include/ main.c -o ref
avr-objcopy -O ihex ref ref.hex
avr-objdump -dx ref > ref.dis
