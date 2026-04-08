ENTRY(_start)

/* TODO: is this useful? */
OUTPUT_FORMAT("elf32-avr","elf32-avr","elf32-avr")
OUTPUT_ARCH(avr:102)

MEMORY
{
  flash  (rx)   : ORIGIN = 0, LENGTH = 64K
  ram    (rw!x) : ORIGIN = 0x6800, LENGTH = 6K
}

SECTIONS {
    .text : {
        KEEP(*(.vectors))
        *(.text)
    } > flash

    /* Read-write data (initialized) */
    .data : {
        _data_start = .;
        *(.rodata)
        *(.rodata.*)
        *(.data)
        *(.data.*)
        _data_end = .;
    } > ram AT > flash
    _data_load_start = LOADADDR(.data);

    /* Read-write data (uninitialized i.e. undefined) */
    .bss (NOLOAD) : {
        _bss_start = .;
        *(.bss)
        *(.bss.*)
        _bss_end = .;
    } > ram
}