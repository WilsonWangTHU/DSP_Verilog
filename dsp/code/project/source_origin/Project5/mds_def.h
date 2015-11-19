/*
* $Source: /cvs/dsptools/sc2/Stage/VisualDSP_4.5/Stage/Blackfin/Examples/Tutorial/fir/mds_def.h,v $
* $Revision: 1.1 $
* $Author: nyee $ $Date: 2005/09/20 19:22:07 $
*/
/****************************************************************************
Copyright (c) 1996 Analog Devices Inc. All rights reserved.
****************************************************************************/
/* @(#) File: mds_def.h
	Date May 15, 1996 $
	Revised Aug 28, 1996
	Version 1.14
	
*/

#ifndef _MDS_DEF_INC
#define _MDS_DEF_INC

typedef	short	fract16;
typedef long	fract32;

typedef struct {
 fract16 re, im;
} complex_fract16;


typedef struct {
     fract16 real, imag;
} cfract16;

typedef struct {
     fract32 real, imag;
} cfract32;

typedef struct {
     float real, imag;
} cfloat;



typedef struct
{
	int k;
	complex_fract16 *h;
	complex_fract16 *d;
	complex_fract16 *p;
}cfir_state_fr16;

typedef struct 
{
    fract16 *c;    /* coefficients                   */
	fract16 *d;    /* start of delay line            */
	int k;       /* number of bi-quad stages       */
} iir_state_fr16;

#define NBITS		16
#define NBITS1		(NBITS-1)
#define NBITS2		(NBITS-2)
#define PROUNDING	(1<<(NBITS-2))
#define RROUNDING	(1<<(NBITS-3))

#define LARGESTP	(fract16)0x7fff
#define LARGESTN	(fract16)0x8000

#define LARGESTLP	(fract32)0x7fffffff
#define LARGESTLN	(fract32)0x80000000

#define MDS_FP_PI	(float)3.1415926535897931
#define MDS_FP_PI2	(float)6.2831853071795862
#define MDS_FP_PIH	(float)1.5707963267948966
#define MDS_FP_PIQ	(float)7.8539816339744828e-01

#define MDS_FP_LOG10	(float)2.3025851249694824

#define MDS_FX_PI	0x40490fdb
#define MDS_FX_PI2	0x40c90fdb
#define MDS_FX_PIH	0x3fc90fdb
#define MDS_FX_PIQ	0x3f490fdb

#define MDS_FX_LOG10	0x40135d8e

#endif /* _MDS_DEF_INC */
