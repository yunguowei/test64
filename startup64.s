

	/*
	 * mov_q - move an immediate constant into a 64-bit register using
	 *         between 2 and 4 movz/movk instructions (depending on the
	 *         magnitude and sign of the operand)
	 */
	.macro	mov_q, reg, val
	.if (((\val) >> 31) == 0 || ((\val) >> 31) == 0x1ffffffff)
	movz	\reg, :abs_g1_s:\val
	.else
	.if (((\val) >> 47) == 0 || ((\val) >> 47) == 0x1ffff)
	movz	\reg, :abs_g2_s:\val
	.else
	movz	\reg, :abs_g3:\val
	movk	\reg, :abs_g2_nc:\val
	.endif
	movk	\reg, :abs_g1_nc:\val
	.endif
	movk	\reg, :abs_g0_nc:\val
	.endm



.global _Reset
_Reset:
    mov x0, #0x10000000
    mov x1, #0xc7000000
    str x0, [x1]
    ldr x30, =stack_top	// setup stack
    mov x1, #0xc7100000
    str x30, [x1]
#if 0
    mov_q x1, 0xffff000081000000
    str x30, [x1]
#endif
    mov sp, x30
    bl c_entry
    b .
