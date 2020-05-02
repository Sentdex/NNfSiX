/**                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
 * Associated YT tutorial: https://youtu.be/TEWy9vZcxW4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
 */

#include <iostream>
#include <vector>
#include <random>
using std::vector;

template<typename T>
std::ostream &operator<<(std::ostream &os,  vector<T> const &vec)
{
    os << '[';
    for (typename vector<T>::const_iterator it = vec.cbegin(), end = vec.cend(); it != end; ++it) {
        if (it != vec.cbegin()) {
            os << ", ";
        }
        os << (*it);
    }
    os << ']';
    return os;
}

vector<vector<double>> dotProduct(vector<vector<double>> const &inputs, vector<vector<double>> const &weights) {

    vector<vector<double>> outputs(inputs.size());

    for (std::size_t i = 0; i < inputs.size(); i++) {
        outputs[i].reserve(weights[0].size());
        for (std::size_t j = 0; j < weights[0].size(); j++) {
            outputs[i].emplace_back(0);
            for (std::size_t k = 0; k < inputs[0].size(); k++) {
                outputs[i][j] += (inputs[i][k]*weights[k][j]);
            }
        }
    }
    return outputs;
}

vector<vector<double>> add(vector<vector<double>> const &inputs, vector<double> const &biases) {
    vector<vector<double>> outputs(inputs.size());

    for (std::size_t i = 0; i < inputs.size(); i++) {
        outputs[i].reserve(biases.size());
        for (std::size_t j = 0; j < biases.size(); j++) {
            outputs[i].emplace_back(inputs[i][j] + biases[j]);
        }
    }
    return outputs;
}

struct Layer_Dense {
    Layer_Dense(std::size_t n_inputs, std::size_t n_neurons) : weights(n_inputs), biases(n_neurons), output() {
        std::mt19937 gen(0);
        std::uniform_real_distribution<double> dis(-1.0, 1.0);
        for (std::size_t i = 0; i < n_inputs; ++i) {
            weights[i].reserve(n_neurons);
            for (std::size_t j = 0; j < n_neurons; ++j) {
                weights[i].emplace_back(dis(gen));
            }
        }
    }

    void forward(vector<vector<double>> const &inputs) {
        output = add(dotProduct(inputs, weights), biases);
    }
    vector<vector<double>> weights;
    vector<double> biases;
    vector<vector<double>> output;
};

int main() {
    vector<vector<double>> const X = {{1.0, 2.0, 3.0, 2.5},
                                      {2.0, 5.0, -1.0, 2.0},
                                      {-1.5, 2.7, 3.3, -0.8}};
    Layer_Dense layer1(4, 5);
    Layer_Dense layer2(5, 2);

    layer1.forward(X);
    //std::cout << layer1.output << std::endl;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    layer2.forward(layer1.output);
    std::cout << layer2.output << std::endl;
}
