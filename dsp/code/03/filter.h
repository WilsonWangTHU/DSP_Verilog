/***************************************************************
 Copyright (c) 2000 Analog Devices Inc. All rights reserved.
 ***************************************************************
  File Name      : filter.h
  Module Name    : FILTER

  ----------------------------------------------------------------------------
  Description    : This header file contains the prototypes for the functions 
                   in the Filter library.
***********************************************************************/

#include "mds_def.h"

#ifndef _FILTER_H
#define _FILTER_H

/* Structures */

/********************************************************************
  Struct name :  fir_state_fr16

 *******************************************************************
  Purpose     :  Filter structure for FIR filter functions.
  Description :  This FIR filter structure contains information 
                 regarding the state of the FIR filter.

 *******************************************************************/

typedef struct 
{
    fract16 *h;    /*  filter coefficients            */
	fract16 *d;    /*  start of delay line            */
	int k;         /*  number of coefficients         */
} fir_state_fr16;


/*******************************************************************

  Struct name :  iir_state

*******************************************************************

  Purpose     :  Filter structure for IIR filter functions.
  Description :  This IIR filter structure contains information 
  				 regarding the state of the IIR filter.
 
********************************************************************/

/* Macros */

#define fir_init(state, coef, delay, samples) \
    (state).h = (coef); \
    (state).d = (delay); \
    (state).k = (samples); \

#define iir_init(state, coef, delay, stages) \
    (state).c = (coef); \
    (state).d = (delay); \
    (state).k = (stages)
    
void _fir( const fract16 x[],fract16 y[],int n,fir_state_fr16 *s );	
void _myfir_Smac_asm( const fract16 x[],fract16 y[],int n,fir_state_fr16 *s );	

#endif

