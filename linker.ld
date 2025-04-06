ENTRY(_start)

SECTIONS {
  . = 0x10000;

  .text : {
    *(.text*)
  }

  .data : ALIGN(4) {
    *(.data*)
  }

  .bss : ALIGN(4) {
    __bss_start__ = .;
    *(.bss*)
    __bss_end__ = .;
  }
}
