#define UART0_BASE 0x101f1000

// Pointers to UART Registers
#define UART_CR    (*(volatile unsigned int *)(UART0_BASE + 0x28))  // Control register
#define UART_LCRH  (*(volatile unsigned int *)(UART0_BASE + 0x2c))  // Line control register, HIGH byte
#define UART_IMSC  (*(volatile unsigned int *)(UART0_BASE + 0x38))  // Interrupt mask set/clear
#define UART_ICR   (*(volatile unsigned int *)(UART0_BASE + 0x44))  // Interrupt clear register

// Initiliaze UART
void uart_init() {
    UART_CR = 0x00000000;                       // Disable UART so we can configure safely
    UART_LCRH = (1 << 4) | (1 << 5) | (1 << 6); // Data frame to 8N1 FIFO enabled
    UART_CR = (1 << 0) | (1 << 8) | (1 << 9);   // Re-enable UART with transmit and recieve enabled
    UART_ICR = 0x7FF;                           // Clear any interrupts
}

#define UART_DR (*(volatile unsigned int *)(UART0_BASE + 0x00)) // Flag register (read only)
#define UART_FR (*(volatile unsigned int *)(UART0_BASE + 0x18)) // Data read or written from the interface

void uart_send(char c) {
    while (UART_FR & (1 << 5));
    UART_DR = c;
}

void uart_puts(const char* str) {
    while (*str) {
        uart_send(*str++);
    }
}

// Main
void kernel_main(void) {
    uart_init();
    uart_puts("Hello from kernel");
    while (1);
}