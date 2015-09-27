#include "mds_def.h"
#include "filter.h"
#include "fir_coeff.h"
#include "fir_input.h"

void myfir(const fract16 * IN, fract16 * OUT, int N, fir_state_fr16 * s)
{
	int i, j, temp, tapL;
	for (i = 0; i < N; i++)
	{
		tapL = (s->k > i) ? (i + 1) : (s->k);
		temp = 0;
		for (j = 0; j < tapL; j++)
		{
			temp += IN[i - j] * (s->h)[j];
		}
		OUT[i] = (temp + 0x3FFF) >> 15;
	}
}
