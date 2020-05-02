/**
 * Creates a dense layer
 *
 * Associated tutorial https://www.youtube.com/watch?v=TEWy9vZcxW4
 */
#include <iostream>
#include <random>
#include <vector>
#include <algorithm>
#include <functional>

using namespace std;


/* A dot product function */
vector<vector<double>> dotProduct(vector<vector<double>> inputs,
                                  vector<vector<double>> weights) {
	// If the inputs is of size (a, b) and weights is of size (b, c)
	// then outputs is of size (a, c)
	vector<vector<double>> outputs = vector<vector<double>>(inputs.size(), \
                        vector<double>(weights[0].size(), 0.0));
	// Calculating the dot product

	for (int i = 0; i < inputs.size(); i++)
		for (int j = 0; j < weights[0].size(); j++)
			for (int k = 0; k < inputs[0].size(); k++)
				outputs[i][j] += inputs[i][k] * weights[k][j];

	return outputs;
}

/* A function to add two vectors */
vector<double> add(vector<double> vector1, vector<double> vector2) {
	vector<double> output(vector1.size());
	// add two vectors element-wise using STL
    transform(vector1.begin(), vector1.end(), vector2.begin(),
                   output.begin(), plus<double>());

	return output;
}

// keep generator global to get different number in each call
std::random_device rd;
std::mt19937 gen(rd());
/* A helper function to get a random float in range [low, high] */
double getRandomDouble(double low, double high) {
        uniform_real_distribution<double> dis(low, high);
        return dis(gen);
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
		weights = vector<vector<double>>(n_inputs, \
                vector<double>(n_neurons, 0.1 * getRandomDouble(-1, 1)));
		biases = vector<double>(n_neurons, 0);
	}

	/* forward pass */
	void forward(vector<vector<double>> inputs) {
		output = dotProduct(inputs, weights);
        for (auto& out: output)
            out = add(out, biases);
	}

	void printOutput() {
	    for (auto row: output) {
            for (auto col: row)
                cout << col << " ";

            cout << "\n";
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
		{   1,   2,    3, 2.5},
		{ 2.0, 5.0, -1.0, 2.0},
		{-1.5, 2.7, 3.3, -0.8},
 	};

 	cout << "First layer forward pass output:" << '\n';
 	l1.forward(X);
 	l1.printOutput();

 	cout << '\n' << "Second layer forward pass output:" << '\n';
 	l2.forward(l1.getOutput());
 	l2.printOutput();
}
