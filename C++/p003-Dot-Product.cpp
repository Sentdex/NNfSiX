/**
 * Creates a simple neuron layer using dot product.
 * 
 * Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
 */

#include <array>
#include <iostream>

int main() {
	std::array<double, 4> inputs = {
		+1.00,
		+2.00,
		+3.00,
		+2.50
	};

	std::array<double, 3 * 4> weights = {
		+0.20, +0.80, -0.50, +1.00,
		+0.50, -0.91, +0.26, -0.50,
		-0.26, -0.27, +0.17, +0.87
	};

	std::array<double, 3> biases = {
		+2.00,
		+3.00,
		+0.50
	};

	std::array<double, 3> outputs;

	// output = weights * inputs + biases
	for(std::size_t row = 0; row < 3; ++row) {
		double sum = 0;
		for(std::size_t col = 0; col < 4; ++col) {
			sum += weights[row * 4 + col] * inputs[col];
		}
		outputs[row] = sum + biases[row];
	}

	std::cout << "[" << outputs[0] << ", " << outputs[1] << ", " << outputs[2] << "]" << std::endl;

	return 0;
}
