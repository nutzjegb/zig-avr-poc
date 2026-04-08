# AVR zig PoC
Example project to test zig on a AVR

Uses avrdude to program the chip.
If you want to compile the reference C example, install avr-libc and gcc-avr.

## Used HW
AVR64EA48 CURIOSITY NANO EVALUATION KIT

## Microzig?
No I didn't use microzig, the HAL looks incomplete and the vector table part is missing?
(at the time of writing..)
I did use the regz tool to generate the CPU definitions
As regz assumes you use microzig I copied some definitions.

## Recommended Zig Version
zig 0.15.2
