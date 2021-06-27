/*
Calculating the loss with Categorical Cross Entropy
Associated with YT NNFS tutorial: https://www.youtube.com/watch?v=dEXPMQXoiLc
*/

import Foundation

var softmax_output: [Double] = [0.7, 0.1, 0.2]
var target_output: [Double] = [1, 0, 0]

var loss = -(log(softmax_output[0]) * target_output[0] +
            log(softmax_output[1]) * target_output[1] +
            log(softmax_output[2]) * target_output[2])

print(loss)

print(-log(0.7))
print(-log(0.5))
