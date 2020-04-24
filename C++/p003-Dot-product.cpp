#include <algorithm>
#include <iostream>
#include <iterator>
#include <numeric>
#include <tuple>
#include <vector>

// implementation of python zip built-in
template <typename T, typename V>
auto zip(T begin1, V begin2, V end2) {
    using data_type1 = typename std::iterator_traits<T>::value_type;
    using data_type2 = typename std::iterator_traits<V>::value_type;

    const auto size = std::distance(begin2, end2);

    auto result = std::vector<std::tuple<data_type1, data_type2>>{};
    result.reserve(size);

    while(begin2 != end2) result.emplace_back(*begin1++, *begin2++);

    return result;
}

// vector pretty printing utility
template <typename T>
void print_range(std::ostream &output, T begin, T end) {
    output << "[ "; 
    while(begin != end)
      output << *begin++ << " ";
    output << ']' << std::endl;
}

int main() {
    // Inputs
    const auto inputs = std::vector<double>{1.0, 2.0, 3.0, 2.5};
    const auto weights = std::vector<std::vector<double>>{
        {.2, 0.8, -0.5, 1.0},
        {0.5, -0.91, 0.26, -0.5},
        {-0.26, -0.27, 0.17, 0.87}
    };
    const auto biases = std::vector<double>{2.0, 3.0, 0.5};
    
    // Zipping
    auto zipped_weights_and_biases = zip(std::begin(weights), std::begin(biases), std::end(biases));
    
    // Calculating
    std::vector<double> outputs;
    outputs.reserve(std::size(weights));
    std::transform(std::begin(zipped_weights_and_biases), std::end(zipped_weights_and_biases), 
		    std::back_inserter(outputs),  [&inputs](const auto &weightAndBias) {
             return std::inner_product(std::begin(std::get<0>(weightAndBias)), 
			     std::end(std::get<0>(weightAndBias)), 
			     std::begin(inputs), 0.0)+std::get<1>(weightAndBias); 
    }); 
	
    // Outputting
    print_range(std::cout, std::begin(outputs), std::end(outputs));

    return 0;
}
