.section program;
.global __myfir_Dmac_asm;
.align 8;
__myfir_Dmac_asm:

	P1 = [SP+12];
	// entre address of struct "s", entre address of array "h"

	I0 = R0; // I0: Address Index of Input;
	I1 = R1; // I1: Address Index of Output;
	P0 = R2; // P0: number of input samples;
	R0 = [P1++];
	B2 = R0; //base address of array of "s.h" (delay line);
	R0 = [P1++];
	B3 = R0; //base address of array of "s.d" (delay line);
	R3 = [P1++]; // R3: number in word of coefficients "s.k";
	P3 = R3; //P3: number in word of coefficients "s.k";
	R3 = R3 + R3; // R3: number in byte of coefficients "s.k";
	L2 = R3; // Length of Circular buffer 2: for filter coefficients "s.h"
	I2 = B2; // buffer for "s.h": Bass address=Index address;
	L3 = R3; // Length of Circular buffer 3: for delay line"s.d"
	I3 = B3; //buffer for "s.d": Bass address=Index address;
	P3 += -1;//P3: number in word of coefficients-1 "s.k";
/*------------------------------------------------------------------------*/


	LSETUP (output_loop_start, output_loop_end) LC0 = P0>>1; 
output_loop_start:	R1.H = W[I0++]; 
	W[I3] = R1.H;  
	A0 = 0 ; A1=0;
	LSETUP (D_inner_Loop_start, D_inner_Loop_end) LC1 = P3;
D_inner_Loop_start:	R0.H = W[I2++]; nop; R0.L=W[I2];
	R1.H = W[I3--];				
D_inner_Loop_end:	A0 += R1.H * R0.H , A1 += R1.H * R0.L;

	// simultaneously caculate two cofficient
	R0.H = W[I2++];nop;R0.L=W[I2];
	R1.H = W[I3--];
	A0 += R1.H * R0.H;
	R1.L = A0 ; 
	W[I1++] = R1.L;
				
	R1.H = W[I0++];
	I3 += 2;
	A1 += R1.H * R0.L;
	R0.H = A1;
	W[I1++] = R0.H;
	W[I3] = R1.H; 
	
output_loop_end:	I3 += 2;

/*------------------------------------------------------------------------*/
	L2=0; // Clear the circular buffer initialization
	L3=0;
	RTS;

__myfir_Dmac_asm.end:
