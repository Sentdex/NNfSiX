# understanding the "dot product"
# video ref: https://youtu.be/tMrbN67U9d4

import libs/common

var
    inputs = vector([1.0, 2.0, 3.0, 2.5])
    weights = matrix(@[
        @[0.2, 0.8, -0.5, 1.0],
        @[0.5, -0.91, 0.26, -0.5],
        @[-0.26, -0.27, 0.17, 0.87]])

    biases = vector([2.0, 3.0, 0.5])

var outputLayer = dot(weights, inputs) + biases

echo outputLayer
# [ 4.8   1.21    2.385 ] #sentdex