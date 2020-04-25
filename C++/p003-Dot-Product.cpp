/**
 * Creates a simple neuron layer using dot product.
 * 
 * Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
 */

#include <iostream>
#include <vector>
using std::vector;


vector<double> dotProduct(vector<vector<double>> weights, vector<double> inputs) {
	vector<double> outputs(weights.size());

	for(int i = 0; i < weights.size(); i++) {
		double output = 0;
		for(int j = 0; j < inputs.size(); j++) {
			output += weights[i][j] * inputs[j];
		}
		outputs[i] = output;
	}

	return outputs;
}

vector<double> add(vector<double> vector1, vector<double> vector2) {
	vector<double> output(vector1.size());

	for(int i = 0; i < vector1.size(); i++) {
		output[i] = vector1[i] + vector2[i];
	}

	return output;
}


int main() {

	vector<double> inputs = {1.0, 2.0, 3.0, 2.5};

	vector<vector<double>> weights = {{0.2, 0.8, -0.5, 1.0},
									  {0.5, -0.91, 0.26, -0.5},
									  {-0.26, -0.27, 0.17, 0.87}};

    vector<double> biases = {2.0, 3.0, 0.5};

	vector<double> output = add(dotProduct(weights, inputs), biases);

	std::cout << "[";
	std::cout << output[0] << ", ";
	std::cout << output[1] << ", ";
	std::cout << output[2] << "]" << std::endl;
}