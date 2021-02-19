/**
 *  P.7 Calculating Loss with Categorical Cross-Entropy
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=dEXPMQXoiLc
 */
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main()
{
    double softmax_output[3] = {0.7,0.1,0.2};
    double target_output[3] = {1.0,0.0,0.0};

    double loss =   -(log(softmax_output[0])*target_output[0] +
                    log(softmax_output[1])*target_output[1] +
                    log(softmax_output[2])*target_output[2]);

    printf("loss %f\n",loss);
    //printf("loss %e\n",loss); // print for more decimals

    //test prints
    //printf("%f\n",-log(0.7));
    //printf("%f\n",-log(0.5));
    return 0;
}
