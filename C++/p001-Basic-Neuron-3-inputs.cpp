/**
 * Creates a basic neuron with 3 inputs
 *
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
 */

#include <array>
#include <iostream>

int main() {
    std::array<double, 3> inputs = {1.0, 2.0, 3.0};
    std::array<double, 3> weights = {3.1, 2.1, 8.7};
    double bias = 3.0;

    double output = inputs[0] * weights[0] +
                    inputs[1] * weights[1] + 
                    inputs[2] * weights[2] + 
                    bias;

    std::cout << output << std::endl;
}
