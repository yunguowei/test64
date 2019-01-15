ENTRY(_Reset)
SECTIONS
{
	. = 0xffff000080100000;
	.startup . : { startup64.o(.text) }
	.text : { *(.text) }
	.data : { *(.data) }
	.bss : { *(.bss COMMON) }
	. = ALIGN(0x1000);
	. = . + 0x1000; /* 4kB of stack memory */ stack_top = .; }
