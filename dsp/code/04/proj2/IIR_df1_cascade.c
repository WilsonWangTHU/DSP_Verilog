/*****************************************************************************
 * IIR_df1_cascade.c
   File Name      : IIR_df1_cascade.c
   Description    : This module tests the iirfir function: iirdf1_fr16.
                    This project performs IIR filter operation on given input.
                    It was written by calling built-in function iirdf1_fr16 indirectly.
                    The project will filter the 1633Hz sine signal
                    
                    input[] - the input array, superposition of a 697Hz and a 1633Hz sine signal, Fs=4000Hz
                   output[] - the outout array
                 a_coeffs[] - the coefficient array of A in float format
                 b_coeffs[] - the coefficient array of B in float format
                     gain   - max of abs(coefficient B)
                 The following equation is the basis of the algorithm.
 
                         B0 + B1*Z(-1) + B2*Z(-2) + ...    
                 H(Z) = ------------------------------- 
                          1 + A1*Z(-1) + A2*Z(-2) + ...    
 *****************************************************************************************************/
#include <filter.h>
#include <filterdata.h>
#include <coefficient.h>
#include <vector.h>
#include <math.h>
#include <fract2float_conv.h>

int main( void )
{
    fract16 temp[NSAMPLES];
    float a_coeffs[2*NSTAGES];
	float b_coeffs[3*NSTAGES];
	iirdf1_state_fr16 state;
	fract16 dfl_coeffs[(4*NSTAGES)+2];
    fract16 delay[(4*NSTAGES)+2];
    int i,j,k;
    
    /*******************************************
    //generate impulse signal    
 ********************************************/   
   for(i=0;i<NSAMPLES;i++)
    {
               
        if(i==0)
        input[i]=0x1000;
        else
        input[i]=0;
        temp[i]=input[i];
    }
/**********************************************
     // input DTMF signal (A: 697,1633Hz)
************************************************/       

  for(i=0;i<NSAMPLES;i++)
    {
        input[i]=W[i]; 
        temp[i]=input[i];     
    }

/************************************************/	
    for(k=0;k<N;k++)
    {
    	for(j=0;j<2*NSTAGES;j++)
    	{
    		a_coeffs[j]=a_c[2*k+j];	
    	}
    	for(j=0;j<3*NSTAGES;j++)
    	{
    		b_coeffs[j]=b_c[3*k+j];
    	}
    	
        iirdf1_init(state,dfl_coeffs,delay,NSTAGES);
  
        for(i=0;i<((4*NSTAGES)+2);i++)
        {
        	delay[i]=0;
        }
    
        if(gain>=1.0F)
        { 
    	    vecsmltf(b_coeffs,(1.0F/gain),b_coeffs,((2*NSTAGES)+1));
        }
        coeff_iirdf1_fr16(a_coeffs,b_coeffs,dfl_coeffs,NSTAGES);

        iirdf1_fr16(temp,output,NSAMPLES,&state);
        for(i=0;i<NSAMPLES;i++)
        {
        	temp[i]=output[i];
        }
    }
	return 0;
}
