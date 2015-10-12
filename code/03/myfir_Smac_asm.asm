/*******************************************************************************************
Copyright(c) 2000 Analog Devices/Intel
Developed by JD(FRIO) Software Application Team, IPDC, Bangalore, India
********************************************************************************************
File Name      : fir_fr16.asm
Module Name    : Finite Impulse response filter 
Function Name  : __fir

Description    : This function performs FIR filter operation on given input.
Operands	   : R0- Address of input vector, R1-Address of output vector,
               : R2- Number of input elements	
			   : Filter structure is on stack.             

Prototype:
		void fir(const fract16 x[],fract16 y[],int n,fir_state_fr16 *s);
    
        x[]  -  input array 
		y[]  -  output array
		n    -  number of input samples(even)
        s    -  Structure of type fir_state_fr16:
	     	{
		    	fract16 *h, // filter coefficients 
			    fract16 *d, // start of delay line 
			    int k,	   	// no. of coefficients 
		    } fir_state_fr16;

Registers used   :   

	R0, R1, R2, R3, R3

	I1 -> Address of delay line (used for updating the delay line)
   	I0 -> Address of delay line (used for fetching the delay line data)
	I2 -> Address of filter coeff. h0, h1 , ... , hn-1
	I3 -> Address of output array y[]

	P0 -> Address of input array x[]
	P1, P2


Computation Time:
Total execution time for Number of Samples= Ni  & number of coefficients = Nc :

Kernal Cycle Count              :       (Ni/2){4 + ((Nc/2-1)*2)}  
Initialization                  :       36 + 5


For Ni=256 & Nc=8      Total execution time = 1321 cycles          

FIR filter code size :	146 bytes	
FIR filter core size :  44 bytes

Modified on 21.3.2001 for moving variable declaration to C and removing unncessary MNOPs.	

********************************************************************************************/
/*   Input buffer(in) , Output buffer(out), Delay line Buffer(delay) and filter coefficient
     buffer(h) are all aligned to 4 byte(word) boundary. The size of the delay line buffer
	 and coefficient buffer has to be 1 word more than the actual size if the number of
	 filter coeff. is odd.

*/

.section program;
.global __myfir_Smac_asm;
.align 8;
__myfir_Smac_asm:

	P1 = [SP + 12];  // entre address of struct "s", entre address of array "h"
				
	I1 = R0;         // I1: Address Index of Input; 
	I0 = R1;         // I0: Address Index of Output;
	P0 = R2;  	     // P0: number of input samples;  
	
	R0 = [P1++]; 
	B2 = R0;         // base address of array of "s.h" (delay line);
	R0 = [P1++]; 
	B3 = R0;         // base address of array of "s.d" (delay line);
	R3 = [P1++];     // R3: number in word of coefficients "s.k";
	P3 = R3;         // P3: number in word of coefficients "s.k";
	
	R3 = R3 + R3;    // R3: number in byte of coefficients "s.k"; 
	L2 = R3;         // Length of Circular buffer 2: for filter coefficients   "s.h"
	
	I2 = B2;         // buffer for "s.h": Bass address=Index address; 
	
	L3 = R3;         // Length of Circular buffer 3: for delay line"s.d"
	
	I3 = B3;         // buffer for "s.d": Bass address = Index address;
	
/*------------------------ THE LOOP PART IS BELOW -----------------------*/
/* FIR Loop by using single MAC, the function is based on the below 
   c function:
   
    int i, j, temp, tapL;
    for (i = 0; i < N; i++) {
        tapL = (s->k > i) ? (i + 1) : (s->k);
        temp = 0;
        for (j = 0; j < tapL; j++) {
            temp += IN[i - j] * (s->h)[j];
        }
    	OUT[i] = (temp + 0x3FFF) >> 15;
    }
	return;

	R4 = 0;					// R4 is the current "i"
	LSETUP(lp_output_start, lp_output_end) LC0 = P0;

lp_output_start:
	R5.L = W[I1++];         // R5 is the IN[i]
	A0 = 0;					// A0 is the temp
	LSETUP (lp_coff_start, lp_coff_end) LC1 = P3;
lp_coff_start:
	R0.H = W[I2++]; //read one coeficient
	R1.H = W[I3--]; //read one data of delay line
lp_coff_end:	A0 += R5.L * R0.H;
				R0.L = A0;
				W[I0++] = R0.L;  // save the result in the output
lp_output_end: 
*/
	LSETUP (lp_output_start, lp_output_end) LC0 = P0; 
lp_output_start:	
	R1.H = W[I1++]; //read one input x into R0.L
	W[I3] = R1.H;   //write the input x into delay line "s.d"
	A0 = 0;
	LSETUP (lp_coff_start, lp_coff_end) LC1 = P3;
lp_coff_start:
	R0.H = W[I2++]; 
	R1.H = W[I3--]; 
lp_coff_end:	A0 += R1.H * R0.H;
				R0.L = A0;
				W[I0++] = R0.L;	
				
lp_output_end:I3 += 2;

/**************************************************************************/
	L2=0;	// Clear the circular buffer initialization
	L3=0;
	RTS;
	
__myfir_Smac_asm.end:			
