/**
 * Network layer structurs
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=TEWy9vZcxW4
 */

#include <stdio.h>
#include <stdlib.h>

#define RAND_HIGH_RANGE (0.10)
#define RAND_MIN_RANGE (-0.10)
#define INIT_BIASES (0.0)

#define NET_BATCH_SIZE 3
#define NET_INPUT_LAYER_1_SIZE 4 // can be replaced with (sizeof(var)/sizeof(double))
#define NET_HIDDEN_LAYER_2_SIZE 5 // can be replaced with (sizeof(var)/sizeof(double))
#define NET_OUTPUT_LAYER_SIZE 2 // can be replaced with (sizeof(var)/sizeof(double))


typedef struct{
    double *weights;
    double *biase;
    double *output;
    int input_size;
    int output_size;
}layer_dense_t;

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

// generate a random floating point number from min to max
double rand_range(double min, double max)
{
    double range = (max - min);
    double div = RAND_MAX / range;
    return min + (rand() / div);
}


/**@brief Setup a layer with random weights and bias as well as allocating memory for the storage buffers.
 *
 * @param[in]   	layer   		Pointer to an empty layer with no values.
 * @param[in]   	intput_size  	Size of the input layer.
 * @param[in]   	output_size	 	Size of the output layer.
 */
void layer_init(layer_dense_t *layer,int intput_size,int output_size){

    layer->input_size = intput_size;
    layer->output_size = output_size;

    //create data as a flat 1-D dataset
    layer->weights = malloc(sizeof(double) * intput_size * output_size);
    if(layer->weights == NULL){
        printf("weights mem error\n");
        return;
    }
    layer->biase   = malloc(sizeof(double) * output_size);
    if(layer->biase == NULL){
        printf("biase mem error\n");
        return;
    }
    layer->output = malloc(sizeof(double) * output_size);

    if(layer->output == NULL){
        printf("output mem error\n");
        return;
    }

    int i = 0;
    for(i = 0; i < (output_size); i++){
           layer->biase[i] = INIT_BIASES;
    }
    for(i = 0; i < (intput_size*output_size); i++){
           layer->weights[i] = rand_range(RAND_MIN_RANGE,RAND_HIGH_RANGE);
    }
}

//free the memory allocated by a layer
void deloc_layer(layer_dense_t *layer){
    if(layer->weights != NULL){
        free(layer->weights);
    }
    if(layer->biase != NULL){
        free(layer->biase);
    }
    if(layer->biase != NULL){
        free(layer->output);
    }
}

/**@brief Does a forward pass in the network from one layer to the next.
 *
 * @param[in]   	previos_layer   		Pointer the previos layer struct.
 * @param[in]   	next_layer  			Pointer the next layer struct.
 */
void forward(layer_dense_t *previos_layer,layer_dense_t *next_layer){
    layer_output((previos_layer->output),next_layer->weights,next_layer->biase,next_layer->input_size,(next_layer->output),next_layer->output_size);
}


int main()
{

    //seed the random values
    srand(0);

    int i = 0;
    int j = 0;
    layer_dense_t X;
    layer_dense_t layer1;
    layer_dense_t layer2;
    double X_input[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE] = {
        {1.0,2.0,3.0,2.5},
        {2.0,5.0,-1.0,2.0},
        {-1.5,2.7,3.3,-0.8}
    };


    layer_init(&layer1,NET_INPUT_LAYER_1_SIZE,NET_HIDDEN_LAYER_2_SIZE);
    layer_init(&layer2,NET_HIDDEN_LAYER_2_SIZE,NET_OUTPUT_LAYER_SIZE);

    for(i = 0; i < NET_BATCH_SIZE;i++){
        X.output = &X_input[i][0];

        forward(&X,&layer1);

        //printf("batch: %d layerX_output: ",i);
        //for(j = 0; j < layer1.output_size; j++){
        //    printf("%f ",layer1.output[j]);
        //}
        //printf("\n");

        forward(&layer1,&layer2);
        printf("batch: %d layerY_output: ",i);
        for(j = 0; j < layer2.output_size; j++){
            printf("%f ",layer2.output[j]);
        }
        printf("\n");
    }


    deloc_layer(&layer1);
    deloc_layer(&layer2);

    return 0;
}


/* test main not using random numbers*/
/*
//#define NET_HIDDEN_LAYER_2_SIZE 4 // can be replaced with (sizeof(var)/sizeof(double))
int main(){

    //seed the random values
    srand (time(NULL));

    int i = 0;
    int j = 0;
    int k = 0;
    int offset = 0;
    layer_dense_t X;
    layer_dense_t layer1;
    layer_dense_t layer2;
    double X_input[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE] = {
        {1.0,2.0,3.0,2.5},
        {2.0,5.0,-1.0,2.0},
        {-1.5,2.7,3.3,-0.8}
    };
    double weights[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE] = {
                                                                {0.2, 0.8, -0.5, 1.0},
                                                                {0.5, -0.91, 0.26, -0.5},
                                                                {-0.26, -0.27, 0.17, 0.87},
                                                                };
    double bias[NET_HIDDEN_LAYER_2_SIZE] = {2.0,3.0,0.5};


    double layer1_output[NET_HIDDEN_LAYER_2_SIZE];

    double weights2[NET_OUTPUT_LAYER_SIZE][NET_HIDDEN_LAYER_2_SIZE] = {
                                                                {0.1, -0.14, 0.5},
                                                                {-0.5, 0.12, -0.33},
                                                                {-0.44, 0.73, -0.13},
                                                                };
    double bias2[NET_OUTPUT_LAYER_SIZE] = {-1.0,2.0,-0.5};

    double layer2_output[NET_OUTPUT_LAYER_SIZE];




    layer1.weights = weights;
    layer1.biase = bias;
    layer1.input_size = NET_INPUT_LAYER_1_SIZE;
    layer1.output_size = NET_HIDDEN_LAYER_2_SIZE;
    layer1.output = layer1_output;


    layer2.weights = weights2;
    layer2.biase = bias2;
    layer2.input_size = NET_HIDDEN_LAYER_2_SIZE;
    layer2.output_size = NET_OUTPUT_LAYER_SIZE;
    layer2.output = layer2_output;

    for(i = 0; i < NET_BATCH_SIZE;i++){
        X.output = &X_input[i][0];

        forward(&X,&layer1);

        //printf("batch: %d layerX_output: ",i);
        //for(j = 0; j < layer1.output_size; j++){
        //    printf("%f ",layer1.output[j]);
        //}
        //printf("\n");

        forward(&layer1,&layer2);
        printf("batch: %d layerY_output: ",i);
        for(j = 0; j < layer2.output_size; j++){
            printf("%f ",layer2.output[j]);
        }
        printf("\n");
    }

}
*/