volatile unsigned int * const UART0DR = (unsigned int *) 0x21c0500;


void print_uart0(const char *s) {
    while(*s != '\0') { 		/* Loop until end of string */
         *UART0DR = (unsigned int)(*s); /* Transmit char */
          s++;			        /* Next char */
    }
}

void mem_write(volatile long *addr) {
	long val = 0;

	while(1)
		*addr = val++;
}
void c_entry() {
	//print_uart0("Hello world!\n");

	mem_write((volatile long *)0xc8000000);
}
