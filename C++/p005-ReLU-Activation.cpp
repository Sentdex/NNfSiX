/**
 * ReLU Activation function class
 * 
 * Associated tutorial https://www.youtube.com/watch?v=gmjzbpSVY1A&t=1349s
 */
#include <iostream>
#include <random>
#include <vector>
using namespace std;

random_device rd;  
mt19937 gen(rd()); 
/* A helper function to get a random float in range [low, high] */
double getRandomDouble(double low, double high) {
    uniform_real_distribution<> dis(low, high);
    return dis(gen);
}

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
		for(int i = 0; i < n_inputs; i++) {
			for(int j = 0; j < n_neurons; j++) {
				/* random weights initialization */
				weights[i][j] = 0.1 * getRandomDouble(-1, 1);
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
		output = vector<vector<double>>(inputs.size(), vector<double>(inputs[0].size(), 0));
		for(int i = 0; i < inputs.size(); i++) {
			for(int j = 0; j < inputs[0].size(); j++) {
				if(inputs[i][j] > 0) {
					output[i][j] = inputs[i][j];
				}
			}
		}
	}
};

int main() {
	Layer_Dense layer1(4, 5);
	Layer_Dense layer2(5, 2);
	Activation_ReLU activation1;

	/* Sample input */
	vector<vector<double>> X = {
		{1, 2, 3, 2.5},
     	{2.0, 5.0, -1.0, 2.0},
     	{-1.5, 2.7, 3.3, -0.8}
 	};

 	cout << "First layer forward pass output:" << endl;
 	layer1.forward(X);
 	printOutput(layer1.output);

 	cout << endl << "First layer activated output:" << endl;
 	activation1.forward(layer1.output);
 	printOutput(activation1.output);

 	cout << endl << "Second layer forward pass output:" << endl;
 	layer2.forward(layer1.output);
 	printOutput(layer2.output);

 	cout << endl << "Second layer activated output:" << endl;
 	activation1.forward(layer2.output);
 	printOutput(activation1.output);
}