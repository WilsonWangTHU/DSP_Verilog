// ASSEMBLY DOT PRODUCT FUNCTION
// File: dotprod_func.asm

.section my_asm_section;

.global _a_dot_c_asm;

_a_dot_c_asm:

	P0 = R0;
	I0 = R1;
	P1 = 19;
	R0 = 0;
	NOP;
	R1 = [P0++];
	R2 = [I0++];
	LSETUP (begin_loop, end_loop) LC0 = P1;

	begin_loop:	R1 *= R2;
				R2 = [I0++];
	end_loop:	R0= R0 + R1 (NS) || R1 = [P0++] || NOP;

	R1 *= R2;
	R0 = R0 + R1;
	RTS;

_a_dot_c_asm.end:






