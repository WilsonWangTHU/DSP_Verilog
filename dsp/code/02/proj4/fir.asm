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

	I0 -> Address of delay line (used for updating the delay line)
   	I1 -> Address of delay line (used for fetching the delay line data)
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
.global    __fir;
.align 8;
__fir :		

			P0=[SP+12];		    // Address of the filter structure
			nop;nop;nop;
			P1=[P0++];			// Address of the filter coefficient array

			P2=[P0++];   		// Address of the delay line

			R3=[P0++];			// Number of filter coefficients

			B3=R1;				//Output buffer initialized as circular buffer
			I2=P1;				// Initialize I2 to the start of the filter coeff. array
			B2=P1;				// Filter coeff. array initialized as a circular buffer
			I0=P2;     			// start of the delay line write pointer 
			B0=P2;				// Delay line buffer is initialized as a circular buffer 	
			I1=P2;     			// start of the delay line read pointer
			B1=P2;				// Delay line buffer is initialized as a circular buffer 	

			I3=R1;
			P1=R2;	    		
			P2=R3;				

			R2=R2+R2;
			CC=BITTST(R3,0);	//Check if the number of filter taps is odd
			R3=R3+R3;			//As the filter coeff. are of fract16 (2 bytes)
			L2=R3;				//Initialize the filter coeff. length register
			P0=R0; 			    // Address of the input array   

			IF !CC JUMP FIR_CONTINUE (BP);
			R3+=2;				//Make the filter taps even			
			L2=R3;
			NOP;NOP;NOP;NOP;
			I2-=2;              // Location where zero  has to be padded to coeff.  
			R0=0;
			W[I2++]=R0.L;		 //Set the last filter coeff. as zero to 
							     //force the number of filter taps even

FIR_CONTINUE:
			L0=R3;      		// Set the length of the delay line buffer
			L1=R3;      		// Set the length of the delay line buffer
			L3=R2;	

			P2+=-1;				//Nc-1 (Number of filter coefficients - 1)
			nop;nop;nop;
			I3-=4;				//Adjust the output pointer to the last location

			
/************************************************************************************************/												

				NOP ;                           // Align the instruction     
				I0+=4 || R2.H=W[I2--];	//Adjust the delay write pointer to X-n	
												//and coeff read pointer to h-n			
				R2.H=W[I2++] || R1=[I0];//Fetch hn-1. Fetch X-n and X-n+1
				R0=[P0++];		// Fetch X0 and X1


				LSETUP(E_FIR_START,E_FIR_END) LC0=P1>>1; //Loop 1 to Ni/2

E_FIR_START:	
				R1=PACK(R1.H,R0.H) || [I0++]=R0 || R2.L=W[I2++];
												//Store X1 into the lower half of R1.
												//Update the delay line.
												//Fetch h0 into lower half of R2
				LSETUP(E_MAC_ST,E_MAC_END)LC1=P2>>1;//Loop 1 to Nc/2 - 1
				A1=R2.L*R1.L, A0=R2.H*R1.H || R2.H=W[I2++] || [I3++]=R3;
												//A1=h0*X1, A0=hn-1*X-n+1.
												//Fetch h1 into upper half of R2.
												//Store the output.

E_MAC_ST:		// The 3 lines of code below can performed in parallel
				A1+=R0.L*R2.H,A0+=R0.L*R2.L || R2.L=W[I2++] || R0=[I1--];

				//A1+=R0.L*R2.H,A0+=R0.L*R2.L;
				//R2.L=W[I2++];					//A1+=X0*h1, A0+=X0*h0
				//R0=[I1--];						//Fetch filter coeff. h2 into the lower
												//half of R2. Fetch X-1 and X-2 into the
												//upper and lower half of R0 (for the 
												//first time in this loop)

E_MAC_END:		A1+=R0.H*R2.L,A0+=R0.H*R2.H  || R2.H=W[I2++] ;	//A1+=X-1*h2, A0+=X-1*h1
												//Fetch h3 into the upper half of R2.
												//(for the first time in this loop)		

E_FIR_END:		R3.H=(A1+=R0.L*R2.H),R3.L=(A0+=R0.L*R2.L)  || R0=[P0++] || R1=[I0]; 
									//A1+=X-n+2*hn-1, A0+=X-n+2*hn+2
									//Fetch the next pair of inputs (X2 and X3) into lower
									//and upper half of R0. Fetch X-n+2 and X-n+3 into R1

				[I3++]=R3;			//Store the final filtered output.

/*************************************************************************************************/
		  	L0=0;              // Clear the circular buffer initialization
			L1=0;
			L2=0;
			L3=0;
			RTS;				

__fir.end:			
