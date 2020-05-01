/**
 * Network layer structurs
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=TEWy9vZcxW4
 */

#include <stdio.h>
#include <stdlib.h>

#define RAND_HIGH_RANGE (0.10)
#define RAND_MIN_RANGE (-0.10)
#define INIT_BAISES (0.0)

#define NET_BATCH_SIZE 3
#define NET_INPUT_LAYER_1_SIZE 4 // can be replaced with (sizeof(var)/sizeof(double))
#define NET_HIDDEN_LAYER_2_SIZE 5 // can be replaced with (sizeof(var)/sizeof(double))
#define NET_OUTPUT_LAYER_SIZE 2 // can be replaced with (sizeof(var)/sizeof(double))


typedef struct{
    double *weights;
    double *baise;
    double *output;
    int input_size;
    int output_size;
}layer_dense_t;

/**@brief Get the dot product of a neuron and add the bais.
 *
 * @param[in]   input   	Pointer to the first address of the inputs.
 * @param[in]   weights  	Pointer to the first address of the weights.
 * @param[in]   bais	 	Pointer to the value of the neurons bais.
 * @param[in]   input_size  number of neurons in the input layer.
 * @retval[out] output		the dot product of the neuron.
 */

double dot_product(double *input,double *weights,double *bais,int input_size){
    int i = 0;
    double output = 0.0;
    for(i = 0;i<input_size;i++){
        output += input[i]*weights[i];
    }
    output += *bais;
    return output;
}

/**@brief Get the dot products of each neuron and add the bais and store it in an output array.
 *
 * @param[in]   	input   		Pointer to the first address of the inputs.
 * @param[in]   	weights  		Pointer to the first address of the weights.
 * @param[in]   	bais	 		Pointer to the first address of the neuron bases.
 * @param[in]   	input_size  	number of neurons in the input layer.
 * @param[in/out]   outputs  		Pointer to the first address of the outputs array.
 * @param[in]   	output_size  	number of neurons in the output layer.
 */

void layer_output(double *input,double *weights,double *bais,int input_size,double *outputs,int output_size){
    int i = 0;
    int offset = 0;
    for(i = 0; i < output_size; i++){
        outputs[i] = dot_product(input,weights + offset,&bais[i],input_size);
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


/**@brief Setup a layer with random weights and bais as well as allocating memory for the storage buffers.
 *
 * @param[in]   	layer   		Pointer to an empty layer with no values.
 * @param[in]   	intput_size  	size of the input layer.
 * @param[in]   	output_size	 	size of the output layer.
 * @param[in]   	batch_size  	number of batches.
 */
void layer_init(layer_dense_t *layer,int intput_size,int output_size, int batch_size){
	
	if(batch_size < 1){
		printf("batch_size must be grater than 0\n");
	}

    layer->input_size = intput_size;
    layer->output_size = output_size;

    //create data as a flat 1-D dataset
    layer->weights = malloc(sizeof(double) * intput_size * output_size);
    if(layer->weights == NULL){
        printf("weights mem error\n");
        return;
    }
    layer->baise   = malloc(sizeof(double) * output_size);
    if(layer->baise == NULL){
        printf("baise mem error\n");
        return;
    }
    layer->output = malloc(sizeof(double) * output_size * batch_size);

    if(layer->output == NULL){
        printf("output mem error\n");
        return;
    }

    int i = 0;
    for(i = 0; i < (output_size); i++){
           layer->baise[i] = INIT_BAISES;
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
    if(layer->baise != NULL){
        free(layer->baise);
    }
    if(layer->baise != NULL){
        free(layer->output);
    }
}

/**@brief Does a forward pass in the network from one layer to the next.
 *
 * @param[in]   	previos_layer   		Pointer the previos layer struct.
 * @param[in]   	next_layer  			Pointer the next layer struct.
 * @param[in]   	batch_index  			current batch index.
 */
void forward(layer_dense_t *previos_layer,layer_dense_t *next_layer, int batch_index){
    int offset = next_layer->output_size * batch_index;
    int input_offset = next_layer->input_size * batch_index;
    layer_output((previos_layer->output + input_offset),next_layer->weights,next_layer->baise,next_layer->input_size,(next_layer->output + offset),next_layer->output_size);
}


int main()
{

    //seed the random values
    srand(0);

    int i = 0;
    int j = 0;
    int offset = 0;
    layer_dense_t X;
    layer_dense_t layer1;
    layer_dense_t layer2;
    double X_input[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE] = {
        {1.0,2.0,3.0,2.5},
        {2.0,5.0,-1.0,2.0},
        {-1.5,2.7,3.3,-0.8}
    };

    X.output = &X_input[0][0];


    layer_init(&layer1,NET_INPUT_LAYER_1_SIZE,NET_HIDDEN_LAYER_2_SIZE,NET_BATCH_SIZE);
    layer_init(&layer2,NET_HIDDEN_LAYER_2_SIZE,NET_OUTPUT_LAYER_SIZE,NET_BATCH_SIZE);

    for(i = 0; i < NET_BATCH_SIZE;i++){
        forward(&X,&layer1,i);
    }

    offset = 0;
    for(i = 0; i < NET_BATCH_SIZE;i++){
        printf("batch: %d layer1_output: ",i);
        for(j = 0; j < layer1.output_size; j++){
            printf("%f ",(layer1.output + offset)[j]);
        }
        offset += layer1.output_size;
            printf("\n");
    }
    printf("\n");


    for(i = 0; i < NET_BATCH_SIZE;i++){
        forward(&layer1,&layer2,i);
    }

    offset = 0;
    for(i = 0; i < NET_BATCH_SIZE;i++){
        printf("batch: %d layer2_output: ",i);
        for(j = 0; j < layer2.output_size; j++){
            printf("%f ",(layer2.output + offset)[j]);
        }
        offset += layer2.output_size;
            printf("\n");
    }
    printf("\n");


    deloc_layer(&layer1);
    deloc_layer(&layer2);

    return 0;
}


/* test main not using random numbers

int main()

    //seed the random values
    srand (time(NULL));

    int i = 0;
    int j = 0;
    int k = 0;
    int offset = 0;
    layer_dense_t X[NET_BATCH_SIZE];
    layer_dense_t layer1;
    layer_dense_t layer2;
    double X_input[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE] = {
        {1.0,2.0,3.0,2.5},
        {2.0,5.0,-1.0,2.0},
        {-1.5,2.7,3.3,-0.8}
    };
    double weights[NET_HIDDEN_LAYER_2_SIZE][NET_INPUT_LAYER_1_SIZE] = {
                                                                {0.2, 0.8, -0.5, 1.0},
                                                                {0.5, -0.91, 0.26, -0.5},
                                                                {-0.26, -0.27, 0.17, 0.87},
                                                                };
    double bais[NET_HIDDEN_LAYER_2_SIZE] = {2.0,3.0,0.5};


    double layer1_output[NET_BATCH_SIZE][NET_HIDDEN_LAYER_2_SIZE];

    double weights2[NET_OUTPUT_LAYER_SIZE][NET_HIDDEN_LAYER_2_SIZE] = {
                                                                {0.1, -0.14, 0.5},
                                                                {-0.5, 0.12, -0.33},
                                                                {-0.44, 0.73, -0.13},
                                                                };
    double bais2[NET_OUTPUT_LAYER_SIZE] = {-1.0,2.0,-0.5};

    double layer2_output[NET_BATCH_SIZE][NET_OUTPUT_LAYER_SIZE];


    for(i = 0; i < NET_BATCH_SIZE;i++){
        X[i].output = &X_input[i][0];
    }

    layer1.weights = weights;
    layer1.baise = bais;
    layer1.input_size = NET_INPUT_LAYER_1_SIZE;
    layer1.output_size = NET_HIDDEN_LAYER_2_SIZE;
    layer1.output = layer1_output;


    layer2.weights = weights2;
    layer2.baise = bais2;
    layer2.input_size = NET_HIDDEN_LAYER_2_SIZE;
    layer2.output_size = NET_OUTPUT_LAYER_SIZE;
    layer2.output = layer2_output;


    for(i = 0; i < NET_BATCH_SIZE;i++){
        forward(&X,&layer1,i);
    }

    offset = 0;
    for(i = 0; i < NET_BATCH_SIZE;i++){
        printf("batch: %d layerx_output: ",i);
        for(j = 0; j < layer1.output_size; j++){
            printf("%f ",(layer1.output + offset)[j]);
        }
        offset += layer1.output_size;
            printf("\n");
    }
    printf("\n");


    for(i = 0; i < NET_BATCH_SIZE;i++){
        forward(&layer1,&layer2,i);
    }

    offset = 0;
    for(i = 0; i < NET_BATCH_SIZE;i++){
        printf("batch: %d layerx_output: ",i);
        for(j = 0; j < layer2.output_size; j++){
            printf("%f ",(layer2.output + offset)[j]);
        }
        offset += layer2.output_size;
            printf("\n");
    }
    printf("\n");

}


*/