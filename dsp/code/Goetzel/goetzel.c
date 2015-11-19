#include "math.h"
#include "goetzel.h"
#include "stdio.h"

float goertzel(int numSamples, int TARGET_FREQUENCY, int SAMPLING_RATE, float* data);

int main() {
    int i_fre = 0;
    int fre[8] = {200, 300, 400, 500, 600, 700, 800, 900};
    for (i_fre = 0; i_fre < 8; i_fre ++) {
        float test = goertzel(399, fre[i_fre], 8000, a);
        printf("Result of %d is: %f\n", fre[i_fre], test);
    }
    return 0;
}

float goertzel(int numSamples, int TARGET_FREQUENCY,
        int SAMPLING_RATE, float* data) {

    int  k,i;
    float floatnumSamples;
    float omega, sine, cosine, coeff;
    float q0, q1, q2, result, real, imag;

    floatnumSamples = (float) numSamples;
    k = (int)(0.5 + ((floatnumSamples * TARGET_FREQUENCY)
                / SAMPLING_RATE));
    omega = (2.0 * M_PI * k) / floatnumSamples;

    sine = sin(omega);
    cosine = cos(omega);
    coeff = 2.0 * cosine;
    q0 = 0;
    q1 = 0;
    q2 = 0;

    for(i = 0; i < numSamples; i++) {
        q0 = coeff * q1 - q2 + data[i];
        q2 = q1;
        q1 = q0;
    }

    real = (q1 - q2 * cosine);
    imag = (q2 * sine);
    result = sqrtf(real * real + imag * imag);
    return result;
}
