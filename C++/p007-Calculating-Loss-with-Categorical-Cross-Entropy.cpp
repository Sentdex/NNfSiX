
/**
 * Calculating Loss with Categorical Cross Entropy
 *
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=dEXPMQXoiLc
 */

#include <iostream>
#include <cmath>

int main() {
    double softmax_outputs[] = {0.7, 0.1, 0.2};
    double target_outputs[] = {1, 0, 0};

    double loss = -(log(softmax_outputs[0]) * target_outputs[0] + 
                    log(softmax_outputs[1]) * target_outputs[1] +
                    log(softmax_outputs[2]) * target_outputs[2]);

    std::cout << loss << std::endl;

    std::cout << -log(0.7) << std::endl;
    std::cout << -log(0.5) << std::endl;
}
