/**
 * P.5 Hidden Layer Activation Functions
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=gmjzbpSVY1A
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define RAND_HIGH_RANGE (0.10)
#define RAND_MIN_RANGE (-0.10)
#define INIT_BIASES (0.0)

#define NET_BATCH_SIZE 300
#define NET_INPUT_LAYER_1_SIZE 2 // Can be replaced with (sizeof(var)/sizeof(double))
#define NET_OUTPUT_LAYER_SIZE 5 // Can be replaced with (sizeof(var)/sizeof(double))

//Callback function template definition
typedef void (*actiavtion_callback)(double * output);

typedef struct{
    double *weights;    /*Neural layer network weights*/
    double *biase;      /*Neural layer network biase*/
    double *output;     /*Output of the neural layer*/
    int input_size;     /*Size of the input layer*/
    int output_size;    /*Size of the output layer*/
	actiavtion_callback callback; /* Pionter to the callback used for the activation function */
}layer_dense_t;

typedef struct{
    double *x; /* Holds the x y axis data. Data is formated x y x y x y*/
    double *y; /* Holds the group the data belongs too. Two steps of x is a single step of y*/
}spiral_data_t;

/**@brief Get the dot product of a neuron and add the bias.
 *
 * @param[in]   input   	Pointer to the first address of the inputs.
 * @param[in]   weights  	Pointer to the first address of the weights.
 * @param[in]   bias	 	Pointer to the value of the neurons bias.
 * @param[in]   input_size  Number of neurons in the input layer.
 * @param[in]   callback    Pionter to the activation callback function.
 * @retval[out] output		The dot product of the neuron.
 */

double dot_product(double *input,double *weights,double *bias,int input_size,actiavtion_callback callback){
	int i = 0;
	double output = 0.0;
	for(i = 0;i<input_size;i++){
		output += input[i]*weights[i];
	}
	output += *bias;
	if(callback != NULL){
		callback(&output);
	}
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
 * @param[in]       callback        Pionter to the activation callback function.
 */

void layer_output(double *input,double *weights,double *bias,int input_size,double *outputs,int output_size,actiavtion_callback callback){
    int i = 0;
    int offset = 0;
    for(i = 0; i < output_size; i++){
        outputs[i] = dot_product(input,weights + offset,&bias[i],input_size,callback);
        offset+=input_size;
    }
}

// Generate a random floating point number from min to max
double rand_range(double min, double max)
{
    double range = (max - min);
    double div = RAND_MAX / range;
    return min + (rand() / div);
}


/**@brief Setup a layer with random weights and bais as well as allocating memory for the storage buffers.
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
    layer_output((previos_layer->output),next_layer->weights,next_layer->biase,next_layer->input_size,(next_layer->output),next_layer->output_size,next_layer->callback);
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

/**@brief Generate a random range in a uniform distribution.
 * @Note Code was lifted from here https://stackoverflow.com/questions/11641629/generating-a-uniform-distribution-of-integers-in-c
 *
 * @param[in]   rangeLow   	Lowest value that in the range that can be genarated.
 * @param[in]   rangeHigh  	Highest value that in the range that can be genarated.
 * @retval[out] rng_scaled	Random mumber that has been generated.
 */
double uniform_distribution(double rangeLow, double rangeHigh) {
    double rng = rand()/(1.0 + RAND_MAX);
    double range = rangeHigh - rangeLow + 1;
    double rng_scaled = (rng * range) + rangeLow;
    return rng_scaled;
}


/**@brief Generate a random range in a uniform distribution.
 * @Note Credit to shreeviknesh (#106) saved alot of time.
 *
 * @param[in]   points   	Number of points to generate per class.
 * @param[in]   classes  	Number of classes to generate.
 * @param[out]  data	    Structure holding the generated spiral data.
 */
void spiral_data(int points,int classes,spiral_data_t *data){

    data->x = (double*)malloc(sizeof(double)*points*classes*2);
    if(data->x == NULL){
        printf("data mem error\n");
        return;
    }
    data->y = (double*)malloc(sizeof(double)*points*classes);
    if(data->y == NULL){
        printf("pionts mem error\n");
        return;
    }
    int ix = 0;
    int iy = 0;
    int class_number = 0;
    for(class_number = 0; class_number < classes; class_number++) {
		double r = 0;
		double t = class_number * 4;

		while(r <= 1 && t <= (class_number + 1) * 4) {
			// adding some randomness to t
			double random_t = t + uniform_distribution(-1.0,1.0) * 0.2;

			// converting from polar to cartesian coordinates
			data->x[ix] = r * sin(random_t * 2.5);
			data->x[ix+1] = r * cos(random_t * 2.5);

			data->y[iy] = class_number;


			// the below two statements achieve linspace-like functionality
			r += 1.0f / (points - 1);
			t += 4.0f / (points - 1);
			iy++;
			ix+=2; // increment index
		}
	}
}


/**@brief Free the allocated memory for the spiral data.
 *
 * @param[in]  data	    Structure holding the generated spiral data.
 */
void deloc_spiral(spiral_data_t *data){
    if(data->x != NULL){
        free(data->x);
    }
     if(data->y != NULL){
        free(data->y);
    }


}


int main()
{

    //seed the random values
    srand(0);

    int i = 0;
    int j = 0;
    spiral_data_t X_data;
    layer_dense_t X;
    layer_dense_t layer1;


    spiral_data(100,3,&X_data);
    if(X_data.x == NULL){
        printf("data null\n");
        return 0;
    }

    X.callback = NULL;
    layer1.callback = actiavtion1;

    layer_init(&layer1,NET_INPUT_LAYER_1_SIZE,NET_OUTPUT_LAYER_SIZE);

    for(i = 0; i < NET_BATCH_SIZE;i++){
        X.output = &X_data.x[i*2];
        forward(&X,&layer1);

        printf("batch: %d layer1_output: ",i);
        for(j = 0; j < layer1.output_size; j++){
            printf("%f ",layer1.output[j]);
        }
        printf("\n");
    }

    deloc_layer(&layer1);
    deloc_spiral(&X_data);
    return 0;
}
