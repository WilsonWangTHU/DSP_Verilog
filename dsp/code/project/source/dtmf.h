
#include <math.h>       /* cos */ 
#include "mds_def.h" 	// FIR stuffs
#include "filter.h"
#include "fir_coeff.h"

extern void dtmf(fract16* output, int length, float f1, float f2, float fs, float Amp);
extern fract16 float_to_fr16(float x);
