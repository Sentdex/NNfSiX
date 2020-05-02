/**
 * Creates a dense layer 
 * 
 * Associated tutorial https://www.youtube.com/watch?v=TEWy9vZcxW4
 */
#include <iostream>
#include <random>
#include <vector>
using namespace std;

/* A helper function to get a random float in range [low, high] */
double getRandomDouble(double low, double high) {
	random_device rd;  
    mt19937 gen(rd()); 
    uniform_real_distribution<> dis(low, high);
    return dis(gen);
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
class DenseLayer {
private:
	vector<vector<double>> weights;
	vector<double> biases;
	vector<vector<double>> output;

public:
	/* Constructor */
	DenseLayer(int n_inputs, int n_neurons) {
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

	void printOutput() {
		for(int i = 0; i < output.size(); i++) {
			for(int j = 0; j < output[0].size(); j++) {
				cout << output[i][j] << " ";
			}
			cout << endl;
		}
	}

	/* Getter for the output variable which is private */
	vector<vector<double>> getOutput() {
		return output;
	}
};

int main() {
	/* Initializing two layers*/ 
	DenseLayer l1(4, 5);
	DenseLayer l2(5, 2);

	/* Sample input */
	vector<vector<double>> X = {
		{1, 2, 3, 2.5},
     	{2.0, 5.0, -1.0, 2.0},
     	{-1.5, 2.7, 3.3, -0.8}
 	};

 	cout << "First layer forward pass output:" << endl;
 	l1.forward(X);
 	l1.printOutput();

 	cout << endl << "Second layer forward pass output:" << endl;
 	l2.forward(l1.getOutput());
 	l2.printOutput();
}