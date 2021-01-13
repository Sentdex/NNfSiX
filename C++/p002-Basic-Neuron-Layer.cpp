/**
 * Creates a simple layer of neurons, with 4 inputs.
 * 
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=lGLto9Xd7bU
 */

#include <array>
#include <iostream>

int main() {
	std::array<double, 4> inputs = { +1.00, +2.00, +3.00, +2.50 };

	std::array<double, 4> weights1 = { +0.20, +0.80, -0.50, +1.00 };
	std::array<double, 4> weights2 = { +0.50, -0.91, +0.26, -0.50 };
	std::array<double, 4> weights3 = { -0.26, -0.27, +0.17, +0.87 };

	double bias1 = 2.0;
	double bias2 = 3.0;
	double bias3 = 0.5;

	std::array<double, 3> outputs = {
			  inputs[0]*weights1[0] + inputs[1]*weights1[1] + inputs[2]*weights1[2] + inputs[3]*weights1[3] + bias1,
			  inputs[0]*weights2[0] + inputs[1]*weights2[1] + inputs[2]*weights2[2] + inputs[3]*weights2[3] + bias2,
			  inputs[0]*weights3[0] + inputs[1]*weights3[1] + inputs[2]*weights3[2] + inputs[3]*weights3[3] + bias3
	};

	std::cout << "[" << outputs[0] << ", " << outputs[1] << ", " << outputs[2] << "]" << std::endl;
}
