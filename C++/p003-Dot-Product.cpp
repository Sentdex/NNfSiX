/**
 * Creates a simple neuron layer using dot product.
 * 
 * Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
 */
#include <iostream>
#include <numeric>
#include <vector>

template<typename T>
void print_vec(const std::vector<T>& vec, const std::string title)
{
    std::cout << "\n----- " << title << " -----\n";
    for (int i{}; i != vec.size(); ++i)
        std::cout << vec[i] << (!((i +  1) % 5) ? "\n" : "  ");
    std::cout << "\n----- " << title << " -----\n";
}


int main() {
	// Inputs
	std::vector<double> inputs{ 1.0, 2.0, 3.0, 2.5 };
	std::vector<std::vector<double>> weights{
		{ 0.2,    0.8,  -0.5,  1.0  },
		{ 0.5,   -0.91, 0.26, -0.5  },
		{ -0.26, -0.27, 0.17,  0.87 }
	};
	std::vector<double> biases{ 2.0, 3.0, 0.5 };
	
	
	// Calculating
	std::vector<double> outputs(biases.size());
	
	// inner product of inputs and weights on every iterate, also init value is biases[i].
	for (size_t i{}; i != weights.size(); ++i)
		outputs[i] = std::inner_product(inputs.begin(), inputs.end(), weights[i].begin(), biases[i]);

	// Ouputing
	print_vec(outputs, "Output");
	
	return 0;
}
