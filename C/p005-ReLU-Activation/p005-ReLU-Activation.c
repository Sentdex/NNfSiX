/**
 * P.5 Hidden Layer Activation Functions
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=gmjzbpSVY1A
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define RAND_HIGH_RANGE (0.10)
#define RAND_MIN_RANGE (-0.10)
#define INIT_BAISES (0.0)

#define NET_BATCH_SIZE 300
#define NET_INPUT_LAYER_1_SIZE 2 // can be replaced with (sizeof(var)/sizeof(double))
#define NET_OUTPUT_LAYER_SIZE 5 // can be replaced with (sizeof(var)/sizeof(double))

//callback function template definition
typedef void (*actiavtion_callback)(double * output);

typedef struct{
    double *weights;
    double *baise;
    double *output;
    int input_size;
    int output_size;
	actiavtion_callback callback;
}layer_dense_t;

/**@brief Get the dot product of a neuron and add the bais.
 *
 * @param[in]   input   	Pointer to the first address of the inputs.
 * @param[in]   weights  	Pointer to the first address of the weights.
 * @param[in]   bais	 	Pointer to the value of the neurons bais.
 * @param[in]   input_size  number of neurons in the input layer.
 * @param[in]   callback    pionter to the activation callback function.
 * @retval[out] output		the dot product of the neuron.
 */

double dot_product(double *input,double *weights,double *bais,int input_size,actiavtion_callback callback){
    int i = 0;
    double output = 0.0;
    for(i = 0;i<input_size;i++){
        output += input[i]*weights[i];
    }
	if(callback != NULL){
        callback(&output);
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
 * @param[in]       callback        pionter to the activation callback function.
 */

void layer_output(double *input,double *weights,double *bais,int input_size,double *outputs,int output_size,actiavtion_callback callback){
    int i = 0;
    int offset = 0;
    for(i = 0; i < output_size; i++){
        outputs[i] = dot_product(input,weights + offset,&bais[i],input_size,callback);
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
    layer_output((previos_layer->output + input_offset),next_layer->weights,next_layer->baise,next_layer->input_size,(next_layer->output + offset),next_layer->output_size,next_layer->callback);
}


//sigmoid activation function
double activation_sigmoid(double x) {
     double result;
     result = 1 / (1 + exp(-x));
     return result;
}

//ReLU activation function
double activation_ReLU(double x){
    if(x < 0.0){
       x = 0.0;
    }
    return x;
}

/**@brief Callback to apply a activation function to the output of a node.
 *
 * @param[in]   output   	Pointer to the dot product output.
 */
void actiavtion1(double *output){
    *output = activation_ReLU(*output);
    //*output = sigmoid(*output);
}


int main()
{

	FILE* f = NULL;

    f = fopen("spiral_data.txt","r");

    if(f == NULL){
        printf("file not found");
    }

    //seed the random values
    srand(0);

    int i = 0;
    int j = 0;
    int offset = 0;
    layer_dense_t X;
    layer_dense_t layer1;
    double X_input[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE];

	X.callback = NULL;
	//bind this layer to the activation function callback
    layer1.callback = actiavtion1;

	//load the spiral data into the input layer (X)
	char line_buffer[100];
    if(f != NULL){
        for(i = 0; i < NET_BATCH_SIZE;i++){
           fgets(line_buffer,sizeof(line_buffer),f);
           sscanf(line_buffer,"[%lf %lf]\n",&X_input[i][0],&X_input[i][1]);
           //printf("%lf %lf\n",X_input[i][0],X_input[i][1]);
        }
        fclose(f);
    }

    X.output = &X_input[0][0];


    layer_init(&layer1,NET_INPUT_LAYER_1_SIZE,NET_OUTPUT_LAYER_SIZE,NET_BATCH_SIZE);

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

    deloc_layer(&layer1);

    return 0;
}

