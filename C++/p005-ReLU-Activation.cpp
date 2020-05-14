/**
 * ReLU Activation function class along with Layer_Dense Class
 * 
 * Associated tutorial https://www.youtube.com/watch?v=gmjzbpSVY1A&t=1349s
 */

#include <iostream>
#include <random>
#include <vector>

// Custom datasets header file
#include "datasets.h"

using namespace std;

/* a helper function to print a vector */
void printOutput(vector<vector<double>> output) {
	for(int i = 0; i < output.size(); i++) {
		for(int j = 0; j < output[0].size(); j++) {
			cout << output[i][j] << " ";
		}
		cout << endl;
	}
}

/* A dot product function */
vector<vector<double>> dotProduct(vector<vector<double>> inputs, vector<vector<double>> weights) {
	// If the inputs is of size (a, b) and weights is of size (b, c) then outputs is of size (a, c)
	vector<vector<double>> outputs = vector<vector<double>>(inputs.size(), vector<double>(weights[0].size()));

	// Calculating the dot product
	for(int i = 0; i < inputs.size(); i++) {
		for(int j = 0; j < weights[0].size(); j++) {
			double output = 0;
			for(int k = 0; k < inputs[0].size(); k++) {
				output += inputs[i][k] * weights[k][j];
			}
			outputs[i][j] = output;
		}
	}
	return outputs;
}

/* A function to add two vectors */
vector<double> add(vector<double> vector1, vector<double> vector2) {
	vector<double> output(vector1.size());
	for(int i = 0; i < vector1.size(); i++) {
		output[i] = vector1[i] + vector2[i];
	}
	return output;
}

/* The dense layer class */
class Layer_Dense {
public:
	vector<vector<double>> weights;
	vector<double> biases;
	vector<vector<double>> output;

	/* Constructor */
	Layer_Dense(int n_inputs, int n_neurons) {
		weights = vector<vector<double>>(n_inputs, vector<double>(n_neurons));
		random_device rd;  
		mt19937 gen(rd()); 
		uniform_real_distribution<> dis(-1, 1);
		for(int i = 0; i < n_inputs; i++) {
			for(int j = 0; j < n_neurons; j++) {
				weights[i][j] = 0.1 * dis(gen);
			}
		}

		// Initializing biases as a vector of zeros
		biases = vector<double>(n_neurons, 0);
	}

	/* forward pass */
	void forward(vector<vector<double>> inputs) {
		output = dotProduct(inputs, weights);
		for(int i = 0; i < output.size(); i++) {
			output[i] = add(output[i], biases);
		}
	}
};

class Activation_ReLU {
public:
	vector<vector<double>> output;
	void forward(vector<vector<double>> inputs) {
		// Initializing the output as zeros
		output = vector<vector<double>>(inputs.size(), vector<double>(inputs[0].size(), 0));
		for(int i = 0; i < inputs.size(); i++) {
			for(int j = 0; j < inputs[0].size(); j++) {
				// Get the value only if it is positive otherwise zero
				if(inputs[i][j] > 0) {
					output[i][j] = inputs[i][j];
				}
			}
		}
	}
};



int main() {
	Layer_Dense layer1(2, 5);
	Activation_ReLU activation1;
	auto data = spiral_data(100, 3);

	vector<vector<double>> X(data.first);
	vector<double> y(data.second);

 	cout << "First layer forward pass output:" << endl;
 	layer1.forward(X);
 	printOutput(layer1.output);

 	cout << endl << "First layer activated output:" << endl;
 	activation1.forward(layer1.output);
 	printOutput(activation1.output);
}