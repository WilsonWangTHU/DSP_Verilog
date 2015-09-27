/****************************************************************************\
* TITLE: 	core_example
* PURPOSE:	Shows some simple Examples to the BF533 EZ-KIT	
* 
*
\****************************************************************************/

#include <defBF533.h>
#include "startup.h"
.global _main;
.section data_a;
.var test[10];

.section L1_code;
_main:
/* ALU examples */
p0.h = test;
p0.l = test;
r0 = 9;
[p0++] = r0;
	    R0 = 3;              	/* load a 3 into an R0 register */ 
        R1 = 5;              	/* load a 5 into an R1 register */ 
        R2 = R0 + R1;       	/* add inputs, store sum in R2 register */ 
        R3 = R0 - R1;       	/* subtract, store result in R3 reg */    
                              	/* look at ALU flags in simlator          */ 
		R3.H = 0x5;				/* Load value into high part of R3 register */	
		R3.L = 0xFFFF;			/* Load value into low part of R3 register */
		R4.H = 0x2;				/* Load value into high part of R4 register */
		R4.L = 0x7;				/* Load value into low part of R4 register */

		R5.L = R3.H + R4.L (NS);/* 16 bit addition, store sum in the low part of R6 - observe result */
		R6 = R3 + R4;			/* 32bit addition, store sum in the R5 register -- observe result */
		R7 = R3 +|+ R4;			/* dual 16 bit addition, store sum in R7 - observe result */
		R7 = R3 +|- R4;			/* dual 16 bit add/sub, store result in R7 - observe result */

		// Saturation
		R3.L = 0x7FFF;			/* Load value into low part of R3 register */
		R4 = 0x7;				/* Load value into high part of R4 register */
		R5 = 0;
		R6 = 0;
		R5.L = R3.L + R4.L (NS);	/* 16 bit addition without saturation */
		R6.L = R3.L + R4.L (S);		/* 16 bit addition with saturation */

/* MAC examples */

		R0.H = 0x0002;				/* Load Input registers with 2 new values */
		R1.H = 0x0003;			
		R2 = R0.H * R1.H;			/* multiply 16 bit inputs, store 32 bit result in R2 */
		R3 = R0.H * R1.H (is);		/* integer multiply */

		R0.L = 0x0005;				/* Load Input registers with 2 new values */
		R1.L = 0x0007;
		R2.L = R0.H * R1.H, R2.H = R0.L * R1.H (is);		/* dual multiply */
		R2 = R0.H * R1.H, R3 = R0.L * R1.H (is);		/* dual multiply */
		R4 *= R0;				/* 32bit multiply */ 
		A0 = R2;
		R2 = (A0 += R0.L * R1.L) (is);			/* multiply and accumulate */
		R2 = (A0 += R0.L * R1.L),R3 = (A1 += R0.H * R1.H)(is);			/* multiply and accumulate */

/* Shifter examples */
		R0 = 0xAAAA (z);		/* load R0, upper 16Bit zero filled */
		R0.H = 0xAAAA;		
		R1 = R0;	
		R0 >>>= 1; 				/* arithmetic shift right */
		R1 >>= 1; 				/* logic shift right */
		R1 = R0 << 24; 			/* logic shift left */
		R2.L = R1.H >> 4;		/* logic shift right */
		R2.H = 0;
		R4 = ROT R2 by -7;		/* rotate right, through the CC- bit */
		R3 = 0x804;
		R7 = EXTRACT(R2,R3.L)(Z);	/* extract bit field */
	
/* the matlab code of implemented */
		R4 = 0;
		R0 = 11;
		R1 = 1;
		R5 = R1.l * R0.l (is);
		R0 = 12;
		R1 = 2;
		R6 = R1.l * R0.l (is);		
		R0 = 6;
		R1 = 3;
		R7 = R1.l * R0.l (is);
		
		R4 = R5 + R7;
		R4 = R4 + R6;
		
end:	nop;
		jump end;


/* end the test program */

_main.END:	





