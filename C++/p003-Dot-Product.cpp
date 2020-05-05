/**
 * Creates a simple neuron layer using dot product.
 * 
 * Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
 */
#include <algorithm>
#include <iostream>
#include <iterator>
#include <numeric>
#include <tuple>
#include <vector>

// Simple implementation of built-in python zip
template<typename T, typename P>
std::vector<std::tuple<T, P>> zip(typename std::vector<T>::iterator firstArrayBegin, 
			 typename std::vector<P>::iterator secondArrayBegin,
			 typename std::vector<P>::const_iterator secondArrayEnd)
{
	const auto size = std::distance(static_cast<decltype(secondArrayEnd)>(secondArrayBegin), secondArrayEnd);
	std::vector<std::tuple<T, P>> zipped;
	zipped.reserve(size);
	while (secondArrayBegin != secondArrayEnd) {
		zipped.emplace_back(*firstArrayBegin++, *secondArrayBegin++);
	}
	return zipped;
}

int main() {
	// Inputs
	std::vector<double> inputs{1.0, 2.0, 3.0, 2.5};
	std::vector<std::vector<double>> weights{{.2, 0.8, -0.5, 1.0},
		{0.5, -0.91, 0.26, -0.5},
		{-0.26, -0.27, 0.17, 0.87}};
	std::vector<double> biases{2.0, 3.0, 0.5};
	
	// Zipping
	auto zipped_weights_and_biases = 
		zip<decltype(weights)::value_type, double>(weights.begin(), biases.begin(), biases.end());
	
	// Calculating
	std::vector<double> outputs;
	outputs.reserve(std::size(zipped_weights_and_biases));
	std::transform(std::begin(zipped_weights_and_biases), std::end(zipped_weights_and_biases), 
		    std::back_inserter(outputs),  [&inputs](const auto &weightAndBias) {
	     return std::inner_product(std::begin(std::get<0>(weightAndBias)), 
			     std::end(std::get<0>(weightAndBias)), 
			     std::begin(inputs), 0.0)+std::get<1>(weightAndBias); 
	}); 

	// Ouputing
	std::cout << '[';
	std::copy(outputs.begin(), outputs.end(), std::ostream_iterator<double>(std::cout, " "));
	std::cout << ']';
	return 0;
}
