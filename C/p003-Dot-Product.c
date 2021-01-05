/**
 * Creates a simple neuron layer using dot product
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
 */

#include <stdio.h>

#define NET_INPUT_LAYER_SIZE 4 // can be replaced with (sizeof(var)/sizeof(double))
#define NET_OUTPUT_LAYER_SIZE 3 // can be replaced with (sizeof(var)/sizeof(double))

/**@brief Get the dot product of a neuron and add the bias.
 *
 * @param[in]   input   	Pointer to the first address of the inputs.
 * @param[in]   weights  	Pointer to the first address of the weights.
 * @param[in]   bias	 	Pointer to the value of the neurons bias.
 * @param[in]   input_size  Number of neurons in the input layer.
 * @retval[out] output		The dot product of the neuron.
 */

double dot_product(double *input,double *weights,double *bias,int input_size){
    int i = 0;
    double output = 0.0;
    for(i = 0;i<input_size;i++){
        output += input[i]*weights[i];
    }
    output += *bias;
    return output;
}

/**@brief Get the dot products of each neuron and add the bias and store it in an output array.
 *
 * @param[in]   	input   		Pointer to the first address of the inputs.
 * @param[in]   	weights  		Pointer to the first address of the weights.
 * @param[in]   	bias	 		Pointer to the first address of the neuron bases.
 * @param[in]   	input_size  	Number of neurons in the input layer.
 * @param[in/out]   outputs  		Pointer to the first address of the outputs array.
 * @param[in]   	output_size  	Number of neurons in the output layer.
 */

void layer_output(double *input,double *weights,double *bias,int input_size,double *outputs,int output_size){
    int i = 0;
    int offset = 0;
    for(i = 0; i < output_size; i++){
        outputs[i] = dot_product(input,weights + offset,&bias[i],input_size);
        offset+=input_size;
    }
}

int main(void)
{
    double input[NET_INPUT_LAYER_SIZE] = {1.0, 2.0, 3.0, 2.5};
    double weights[NET_OUTPUT_LAYER_SIZE][NET_INPUT_LAYER_SIZE] = {
                                                                {0.2, 0.8, -0.5, 1.0},
                                                                {0.5, -0.91, 0.26, -0.5},
                                                                {-0.26, -0.27, 0.17, 0.87},
                                                                };
    double bias[NET_OUTPUT_LAYER_SIZE] = {2.0,3.0,0.5};

    double output[NET_OUTPUT_LAYER_SIZE] = {0.0};
    layer_output(&input[0],&weights[0][0],&bias[0],NET_INPUT_LAYER_SIZE,&output[0],NET_OUTPUT_LAYER_SIZE);
    printf("nur output: %f %f %f\n",output[0],output[1],output[2]);

    return 0;
}