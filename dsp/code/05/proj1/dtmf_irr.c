/* in this function, we calculate the coefficient to be send */

#include <dtmf.h>

extern void dtmf(fract16* output, int length2, float f1, float f2, float fs, float Amp) {
	
	int length = length2 / 2;
	
	float a1 = -2 * cos(2 * 3.1415 * f1 / fs);
	float a2 = 1;

	float b1 = -2 * cos(2 * 3.1415 * f2 / fs);
	float b2 = 1;
		
	float out_1[2] = {0, -Amp * sin(2 * 3.1415 * f1 / fs)};  // out_1 is the coeff for f1
	float out_2[2] = {0, -Amp * sin(2 * 3.1415 * f2 / fs)};

	float temp = 0;
	int i = 0;

	for (i = 0; i < length; i ++) {
		/*
	    if (i < length / 4 || i > length / 4 * 3) {
			output[i] = 0;
			continue;
		}
		*/
		
		temp = - a1 * out_1[0] - a2 * out_1[1];
		out_1[1] = out_1[0];
		out_1[0] = temp;

		temp = - b1 * out_2[0] - b2 * out_2[1];
		out_2[1] = out_2[0];
		out_2[0] = temp;

		output[2 * i] = float_to_fr16((out_1[0] + out_2[0]));
		output[2 * i + 1] = output[2 * i];
	}
	
}


extern fract16 float_to_fr16(float x) {
	int temp;

	fract32 result;
	temp = *(int *)(&x);

	if ((temp & 0x7f800000) >= 0x3f800000) {
	    result = 0x7fffffff;
	    if (temp < 0)  result = 0x80000000;  // overflow
	} else {
	    temp = temp + 0x0f800000;
	    result = *(float *)(&temp);
	}

	return (result >> 16);

}
