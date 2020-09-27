/*
*   Doing dot product with a layer of neurons and multiple inputs
*   Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
*/

#include <stdio.h>

int main() {
    float inputs[4] = {1.0f, 2.0f, 3.0f, 2.5f};
    float weights[3][4] = {{0.2f, 0.8f, -0.5f, 1.0f},{0.5f, -0.91f, 0.26f, -0.5f},{-0.26f, -0.27f, 0.17f, 0.87f}};
    float biases[3] = {2.0f, 3.0f, 0.5f};
    float neuron_output, layer_outputs[3];
    int n_inputs, n_neurons;
    for(n_neurons = 0; n_neurons < 3; n_neurons++){
        neuron_output = 0;
        for(n_inputs = 0; n_inputs < 4; n_inputs++)
            neuron_output += weights[n_neurons][n_inputs] * inputs[n_inputs];
        neuron_output += biases[n_neurons];
        layer_outputs[n_neurons] = neuron_output;
    }
    printf("[%f, %f, %f]\n", layer_outputs[0], layer_outputs[1], layer_outputs[2]);
    return 0;
}