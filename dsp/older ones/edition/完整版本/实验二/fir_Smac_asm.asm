.section program;
.global __fir_Smac_asm;
.align 8;
__fir_Smac_asm:

	P1 = [SP+12];	
	// entre address of struct "s", entre address of array "h"

	I1 = R0; // I0: Address Index of Input; 
	I0 = R1; // I1: Address Index of Output;
	P0 = R2; // P0: number of input samples;  
	R0 = [P1++]; 
	B2 = R0; //base address of array of "s.h" (delay line);
	R0 = [P1++]; 
	B3 = R0; //base address of array of "s.d" (delay line);
	R3 = [P1++]; // R3: number in word of coefficients "s.k";
	P3 = R3; //P3: number in word of coefficients "s.k";
	R3=R3+R3; // R3: number in byte of coefficients "s.k"; 
	L2 = R3; // Length of Circular buffer 2: for filter coefficients   "s.h"
	I2 = B2; // buffer for "s.h": Bass address=Index address; 
	L3 = R3; // Length of Circular buffer 3: for delay line"s.d"
	I3 = B3; //buffer for "s.d": Bass address=Index address;
/************************************************************************/
// FIR Loop by using single MAC	
	
	LSETUP (FIR_Loop_START, FIR_Loop_END) LC0 = P0; 
		//loop count = number of input samples
FIR_Loop_START:	R1.H = W[I1++]; //read one input x into R0.L
				W[I3] = R1.H;   //write the input x into delay line "s.d"
				A0 = 0;
	LSETUP (SMAC_Loop_START, SMAC_Loop_END) LC1 = P3;
		//loop count = number of coeficient
SMAC_Loop_START:	R0.H = W[I2++]; //read one coeficient
					R1.H = W[I3--]; //read one data of delay line
SMAC_Loop_END:	A0 += R1.H * R0.H;
				R0.L = A0;
				W[I0++] = R0.L;				
FIR_Loop_END:I3 += 2;

/**************************************************************************/
	L2=0;	// Clear the circular buffer initialization
	L3=0;
	RTS;
	
__fir_Smac_asm.end:			
