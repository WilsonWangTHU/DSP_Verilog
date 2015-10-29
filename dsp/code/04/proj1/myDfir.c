#include "mds_def.h"
#include "filter.h"
#include "fir_coeff.h"
#include "fir_input.h"

void _myDfir(const fract16 *IN, fract16 *OUT, int N, fir_state_fr16 *s)
{
    int i, j, k, temp1, temp2, tapL;
    for ( i =0; i < N; i++) {
        tapL = (s->k > i) ? (i + 1) : (s->k);
        temp1 = 0;
        temp2 = 0;        
        for( j = 0; j < tapL; j++) {
            temp1 += IN[i - j] * (s->h)[j];
            k = (j + 1) % 8;
            temp2 += IN[i-j] * (s->h)[k];
        }
        
        OUT[i] = (temp1 + 0x3FFF) >> 15;
        i++;
    	OUT[i] = (temp2 + 0x3FFF) >> 15;
    }
}