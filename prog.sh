#!/bin/sh

set -ex

zig build
avrdude -p avr64ea48 -c pkobn_updi -U flash:w:zig-out/bin/avr_poc.hex
