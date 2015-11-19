
/****************************************************************************
 Copyright (c) 2015 Analog Devices Inc. All rights reserved.
 ***************************************************************************
  File Name      : my_fir.c
  Description    : This module tests the fir function.

***************************************************************************/

/* Includes */
#include "filter.h"

void my_fir(const fract16* IN, fract16* OUT,int N, fir_state_fr16* s) {
    /* the s contains 
    fract16 *h;      filter coefficients            
	fract16 *d;      start of delay line            
	int k;           number of coefficients */
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
	
}