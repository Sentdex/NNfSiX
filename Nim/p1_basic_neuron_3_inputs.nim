# a single neuron w/ 3 inputs
# video ref: https://youtu.be/Wo5dMEP_BbI

let
    inputs = [1.2, 5.1, 2.1]
    weights = [3.1, 2.1, 8.7]

    bias = 3.0

let output = inputs[0] * weights[0] +
        inputs[1] * weights[1] +
        inputs[2] * weights[2] + bias

echo output
# 35.7
