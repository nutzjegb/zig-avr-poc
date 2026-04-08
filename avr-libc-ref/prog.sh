#!/bin/sh

set -ex

avrdude -p avr64ea48 -c pkobn_updi -U flash:w:ref.hex
