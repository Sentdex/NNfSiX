/**
 *Creates a simple layer of neurons with 4 inputs and 3 outputs.
 * Associated YT NNFS tutorial :https://www.youtube.com/watch?v=tMrbN67U9d4
 */

#include<stdio.h>

int main()
{

int bia , input ,i;
float weights_inputs;

float inputs[] = {1.0 , 2.0 , 3.0 , 2.5};
int inputs_size = sizeof(inputs)/sizeof(inputs[0]);

float weights[3][4]={{0.2, 0.8, -0.5, 1.0},{0.5, -0.91, 0.26, -0.5},{-0.26, -0.27, 0.17, 0.87}};

float biases[]={2.0 , 3.0 , 0.5};
int biases_size = sizeof(biases)/sizeof(biases[0]);

float outputs[biases_size];

for(bia=0; bia<biases_size ; bia++){
	weights_inputs=0;
	for(input=0; input<inputs_size; input++){
		weights_inputs+=weights[bia][input]*inputs[input];
	}

outputs[bia]=weights_inputs + biases[bia];


}

int outputs_size = sizeof(outputs)/sizeof(outputs[0]);
 

for(i=0;i<outputs_size;i++)
	printf("%f\n",outputs[i]);

return(0);
}
