.global _start
.extern kernel_main

.section .text
_start:
    bl kernel_main      @ Call C function kernel_main()
    b .                 @ Infinite loop after kernel_main returns (just halt)
