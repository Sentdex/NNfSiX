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
#define NET_INPUT_LAYER_1_SIZE 2 // can be replaced with (sizeof(var)/sizeof(double))
#define NET_OUTPUT_LAYER_SIZE 5 // can be replaced with (sizeof(var)/sizeof(double))

//callback function template definition
typedef void (*actiavtion_callback)(double * output);

typedef struct{
    double *weights;    /*neural layer network weights*/
    double *biase;      /*neural layer network biase*/
    double *output;     /*output of the neural layer*/
    int input_size;     /*size of the input layer*/
    int output_size;    /*size of the output layer*/
	actiavtion_callback callback; /* pionter to the callbacb used for the activation function */
}layer_dense_t;

/** Forward decleration the spiral data. Don't want to scroll 300 lines to get to the code
*   Details on generation at the decleration of the  spiral data.
*   This was solely done for readablity.
*/
extern double spiral_data[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE];

/**@brief Get the dot product of a neuron and add the bias.
 *
 * @param[in]   input   	Pointer to the first address of the inputs.
 * @param[in]   weights  	Pointer to the first address of the weights.
 * @param[in]   bias	 	Pointer to the value of the neurons bias.
 * @param[in]   input_size  number of neurons in the input layer.
 * @param[in]   callback    pionter to the activation callback function.
 * @retval[out] output		the dot product of the neuron.
 */

double dot_product(double *input,double *weights,double *bias,int input_size,actiavtion_callback callback){
    int i = 0;
    double output = 0.0;
    for(i = 0;i<input_size;i++){
        output += input[i]*weights[i];
    }
	if(callback != NULL){
        callback(&output);
    }
    output += *bias;
    return output;
}

/**@brief Get the dot products of each neuron and add the bias and store it in an output array.
 *
 * @param[in]   	input   		Pointer to the first address of the inputs.
 * @param[in]   	weights  		Pointer to the first address of the weights.
 * @param[in]   	bias	 		Pointer to the first address of the neuron bases.
 * @param[in]   	input_size  	number of neurons in the input layer.
 * @param[in/out]   outputs  		Pointer to the first address of the outputs array.
 * @param[in]   	output_size  	number of neurons in the output layer.
 * @param[in]       callback        pionter to the activation callback function.
 */

void layer_output(double *input,double *weights,double *bias,int input_size,double *outputs,int output_size,actiavtion_callback callback){
    int i = 0;
    int offset = 0;
    for(i = 0; i < output_size; i++){
        outputs[i] = dot_product(input,weights + offset,&bias[i],input_size,callback);
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
 * @param[in]   	intput_size  	size of the input layer.
 * @param[in]   	output_size	 	size of the output layer.
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


int main()
{

    //seed the random values
    srand(0);

    int i = 0;
    int j = 0;
    layer_dense_t X;
    layer_dense_t layer1;

    X.callback = NULL;
    layer1.callback = actiavtion1;

    layer_init(&layer1,NET_INPUT_LAYER_1_SIZE,NET_OUTPUT_LAYER_SIZE);

    for(i = 0; i < NET_BATCH_SIZE;i++){
        X.output = &spiral_data[i][0];
        forward(&X,&layer1);

        printf("batch: %d layer1_output: ",i);
        for(j = 0; j < layer1.output_size; j++){
            printf("%f ",layer1.output[j]);
        }
        printf("\n");
    }

    deloc_layer(&layer1);

    return 0;
}


/*
This was generated using python with the following code.
/////////////////////////////////////////////////////////
import numpy as np
import nnfs
from nnfs.datasets import spiral_data

nnfs.init()

X, y = spiral_data(100, 3)

f = open("spiral_data.txt","w+")
print(len(X))
for z in X:
	#print(z)
	k = str(z).replace('[','{')
	k = k.replace(']','},')
	k = k.replace('{ ','{')
	k = k.replace('   ',',')
	k = k.replace('  ',',')
	k = k.replace(' ',',')
	f.write(k + '\n')

f.close()
/////////////////////////////////////////////////////////
*/

double spiral_data[NET_BATCH_SIZE][NET_INPUT_LAYER_1_SIZE] = {

    {0.0,0.0},
    {0.00299556,0.00964661},
    {0.01288097,0.01556285},
    {0.02997479,0.0044481,},
    {0.03931246,0.00932828},
    {0.00082883,0.05049825},
    {0.05348352,0.02850628},
    {0.0417362,0.05707521},
    {0.05546339,0.05876868},
    {0.08160383,0.04006591},
    {0.08918751,0.0474197,},
    {0.10716084,-0.02936382},
    {0.1211832,-0.00264751},
    {0.12877773,0.02567947},
    {0.14111297,-0.00922449},
    {0.15057947,-0.01681263},
    {0.11347637,-0.11507779},
    {0.17155251,-0.00751816},
    {0.16718684,-0.07145914},
    {0.19132587,0.01507932},
    {0.1367719,0.14867955},
    {0.13560642,-0.1631144,},
    {0.10402475,-0.19637099},
    {0.21563354,-0.08646537},
    {-0.09830333,-0.22159867},
    {0.24603142,-0.05689945},
    {0.12416625,-0.23142017},
    {0.13264194,-0.23829873},
    {-0.1238043,-0.25429183},
    {-0.14615527,-0.2538626,},
    {0.01024529,-0.30285707},
    {-0.05569058,-0.30813923},
    {0.11179529,-0.3032836,},
    {0.23880671,-0.23255637},
    {-0.04070229,-0.34101388},
    {-0.16072105,-0.31489044},
    {-0.32569507,-0.16172235},
    {-0.34792605,-0.13648112},
    {-0.18507461,-0.33627266},
    {-0.23735482,-0.31440568},
    {-0.14781402,-0.37603146},
    {-0.11835026,-0.39687067},
    {-0.10401209,-0.41129443},
    {-0.356894,0.24754977},
    {-0.3850841,-0.2219034},
    {-0.42110595,-0.17111792},
    {-0.357669,-0.29659605},
    {-0.43274188,0.19524248},
    {-0.37977776,-0.3014082,},
    {-0.49072573,0.06452346},
    {-0.5020192,-0.05525143},
    {-0.41547295,0.30457067},
    {-0.504104,0.14754443},
    {-0.53466207,0.02720043},
    {-0.4071617,0.36296004},
    {-0.2728874,0.48391575},
    {-0.31628728,0.46896663},
    {-0.21054855,0.5358788,},
    {-0.39579841,0.43194202},
    {-0.2883088,0.52158016},
    {-0.32131946,0.51387084},
    {-0.1828802,0.5883961},
    {-0.25943702,0.5699976,},
    {-0.4487569,0.45119387},
    {0.17254099,0.62301373},
    {0.05350375,0.654382,},
    {-0.27889386,0.60552675},
    {0.44415152,0.5106309,},
    {0.09030307,0.6809067,},
    {0.4556201,0.52742493},
    {0.6459843,0.28749484},
    {0.58461714,0.41540107},
    {0.7272242,0.00840271},
    {0.33600855,0.6563675,},
    {0.7356561,0.13239563},
    {0.61629754,0.44056597},
    {0.62807363,0.44141942},
    {0.72636604,0.27808395},
    {0.78113115,0.10289375},
    {0.7885484,-0.12232409},
    {0.7574837,0.28144813},
    {0.5826627,-0.57439154},
    {0.653484,-0.50893134},
    {0.8146986,0.19787292},
    {0.16507667,-0.83227175},
    {-0.09342218,-0.85348815},
    {0.12854312,-0.8591237,},
    {0.5839789,-0.65668625},
    {0.7802732,-0.42579007},
    {-0.08290096,-0.89515936},
    {0.46384948,-0.78185034},
    {-0.3395499,-0.8541778},
    {0.0257485,-0.9289361},
    {-0.41492042,-0.8427942,},
    {-0.23339489,-0.9203627,},
    {-0.48052034,-0.830617,},
    {-0.26559624,-0.93261504},
    {-0.93467754,-0.2939081,},
    {-0.50696135,-0.8502295,},
    {-0.7005848,-0.71356916},
    {-0.0,-0.0},
    {-2.3763678e-05,-1.0100982e-02},
    {-0.00285905,-0.01999869},
    {-0.02965084,-0.0062531,},
    {-0.01546202,-0.03732844},
    {-0.04476767,0.02337981},
    {-0.05014583,-0.03403661},
    {-0.05576118,-0.04347621},
    {-0.05778877,0.05648366},
    {-0.07216311,0.05528969},
    {-0.05889495,0.08206354},
    {-0.09363085,0.05982427},
    {-0.11844549,-0.02574967},
    {-0.03858067,0.1255176,},
    {-0.13572699,0.03970066},
    {-0.09169381,0.12061959},
    {-0.07414071,0.14360689},
    {-0.1373128,0.10311151},
    {-0.07763252,0.1644112,},
    {-0.0355057,0.18860626},
    {-0.07077987,0.18921515},
    {-0.17790227,0.11552572},
    {-0.04306562,0.21800934},
    {0.09474382,0.2121266,},
    {-0.11396535,0.21396591},
    {-0.02921107,0.25083005},
    {-0.04124076,0.259368,},
    {0.24124162,0.12721102},
    {0.15924361,0.23373769},
    {0.15724778,0.24714512},
    {0.02390676,0.3020858,},
    {0.23203215,0.21026722},
    {0.10436996,0.30591837},
    {0.2351075,0.23629552},
    {0.17952332,0.29277727},
    {0.3413239,0.09211532},
    {0.35545638,0.07669528},
    {0.32727644,0.18047096},
    {0.3818908,0.03861769},
    {0.28976595,0.26687813},
    {0.2689616,0.30151004},
    {0.40380004,-0.09197084},
    {0.4167201,-0.07953615},
    {0.3761124,-0.21724106},
    {0.03194858,-0.44329464},
    {0.28942937,-0.35048854},
    {0.4639968,-0.02456211},
    {0.18574098,-0.4369044,},
    {0.48415828,-0.02586128},
    {0.41358972,-0.27187964},
    {0.32209808,-0.38901007},
    {-0.15234753,-0.49210906},
    {0.38682503,-0.3553261,},
    {0.37177315,-0.3852118,},
    {0.16257009,-0.52066463},
    {0.25858524,-0.49170688},
    {-0.27708817,-0.49314246},
    {0.27114585,-0.50791407},
    {0.24055341,-0.53419507},
    {-0.0194979,-0.59564054},
    {-0.06269164,-0.6028094,},
    {-0.60902214,-0.09352617},
    {-0.5366922,-0.32274815},
    {-0.40968832,-0.4869437,},
    {-0.09274741,-0.6397769,},
    {-0.62897676,-0.18832612},
    {-0.29512626,-0.5977834,},
    {-0.1917897,-0.64902323},
    {-0.6752814,0.12563285},
    {-0.6890818,-0.10456134},
    {-0.6846719,0.17655998},
    {-0.7161903,0.03750631},
    {-0.6633561,0.29813468},
    {-0.717866,-0.16848874},
    {-0.7092625,-0.2359347},
    {-0.6086443,0.45107996},
    {-0.7676715,-0.0028379},
    {-0.7685441,0.11949187},
    {-0.73391455,0.28657,},
    {-0.60527295,0.5200158,},
    {-0.65529937,0.47283965},
    {-0.79924244,0.17502293},
    {-0.6428717,0.52227235},
    {-0.83836544,-0.00555246},
    {-0.04417903,0.8473339,},
    {-0.75096744,0.4161941,},
    {-0.5694468,0.65600854},
    {-0.03127349,0.8782312,},
    {-0.2884154,0.84079725},
    {0.7107756,0.550437,},
    {-0.3582618,0.8355207},
    {0.4211081,0.8170568},
    {0.38209292,0.84710705},
    {-0.03724965,0.93865514},
    {0.74789685,0.5849709,},
    {0.5888223,0.75770223},
    {0.914996,0.32108328},
    {0.9581458,0.20484303},
    {0.83856255,-0.5260351,},
    {0.969427,-0.24538004},
    {0.0,0.0},
    {0.00914307,0.00429357},
    {0.01910214,-0.00657494},
    {0.02963534,-0.00632615},
    {0.03855436,-0.01208503},
    {0.03784384,0.03344553},
    {0.05969568,-0.01046518},
    {0.07046776,0.00581241},
    {0.06981593,-0.04069007},
    {0.08226318,-0.03869409},
    {0.0507113,-0.08735792},
    {0.0733842,-0.08342924},
    {0.04561929,-0.11229986},
    {0.103771,-0.08046563},
    {0.12261172,-0.07045798},
    {0.09539202,-0.11771663},
    {0.06047126,-0.14987665},
    {0.0144759,-0.17110592},
    {-0.14859772,-0.10476912},
    {0.01783906,-0.19108832},
    {0.08767515,-0.18200338},
    {0.009103,-0.2119258},
    {1.6096578e-04,-2.2222216e-01},
    {-0.12592101,-0.19523828},
    {0.08022906,-0.22876365},
    {-0.13536273,-0.21318053},
    {-0.17185836,-0.19858816},
    {-0.20529279,-0.17954119},
    {-0.14504237,-0.24280557},
    {-0.21401079,-0.2000174,},
    {-0.09736996,-0.28696072},
    {-0.24401473,-0.19623464},
    {-0.26658294,-0.18279135},
    {-0.3332627,-0.00686169},
    {-0.26140934,-0.2227382,},
    {-0.33037084,0.12586641},
    {-0.24763848,0.26628292},
    {-0.24396384,-0.28312767},
    {-0.33875117,0.18049806},
    {-0.29722762,0.25854206},
    {-0.3988964,0.06426753},
    {-0.38447034,0.15393397},
    {-0.346745,0.24443719},
    {-0.3502965,0.25680068},
    {-0.3317828,0.29572123},
    {-0.44974202,0.06590674},
    {0.04171048,0.46277055},
    {0.0730771,0.46908945},
    {-0.3089749,0.37364763},
    {-0.39271823,0.3012431,},
    {0.08957227,0.4970441,},
    {-0.13697018,0.49660876},
    {0.09959091,0.5157246,},
    {0.03270574,0.53435355},
    {0.33768126,0.4283597,},
    {0.38681713,0.3987662,},
    {0.09069215,0.5583389,},
    {-0.03845929,0.57447165},
    {-0.03841914,0.5845975,},
    {0.53951186,0.25316954},
    {0.19835815,0.57268095},
    {0.43134362,0.43999752},
    {0.46286848,0.42185026},
    {0.59417284,0.22785372},
    {0.23000933,0.60416245},
    {0.6559448,0.02854615},
    {0.6498516,-0.14878607},
    {0.672799,-0.07318456},
    {0.6868363,-0.00666679},
    {0.6627066,-0.21583958},
    {0.5965422,-0.37958714},
    {0.4355508,0.5697638},
    {0.01719869,-0.7270693,},
    {0.47815186,-0.56132954},
    {0.6746769,-0.32176018},
    {0.59061843,-0.47443742},
    {0.26373604,-0.7209514,},
    {0.40958568,-0.66119426},
    {0.77782696,-0.12545194},
    {-0.5367176,-0.5905133},
    {0.19897966,-0.78319967},
    {-0.33180633,-0.74788105},
    {0.27429247,-0.78154725},
    {-0.644941,-0.5356665},
    {-0.29387987,-0.79596555},
    {-0.49603206,-0.7008009,},
    {0.09544232,-0.8634278,},
    {-0.7906592,-0.3835703},
    {-0.727897,-0.5101857},
    {-0.88029236,-0.18239574},
    {-0.43785957,-0.7966965,},
    {-0.5758861,-0.716428,},
    {-0.7671058,0.5245322},
    {-0.522328,-0.78079087},
    {-0.867686,-0.38556677},
    {-0.91110104,0.3011964,},
    {-0.9649202,-0.09613083},
    {-0.95069844,0.23701589},
    {-0.9793868,-0.14387996},
    {-0.9427888,0.33339068},
};
