# Bare-Metal ARM Kernel

This is a minimal bare-metal kernel written in **ARM Assembly and C**, targeting the **QEMU VersatilePB** board. It demonstrates how to:

- Boot from raw ARM assembly
- Set up UART (PL011) for serial output
- Write kernel logic in C
- Print to the QEMU terminal using custom `uart_send()` and `uart_puts()`

## What It Does

When run in QEMU, this kernel:

1. Initializes UART (serial communication)
2. Prints `Hello from kernel` to the terminal
3. Halts the CPU in an infinite loop

It's a starting point for building an embedded shell, drivers, or even a hobby OS.

