#!/bin/sh

set -ex

sudo avrdude -p avr64ea48 -c pkobn_updi -U flash:w:a.hex
