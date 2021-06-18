# understanding hidden layer activation functions (Rectified Linear Unit)
# video ref: https://youtu.be/gmjzbpSVY1A


import libs/common, libs/dataset1
from random import rand
#dataset1 module is temporary, will create a function to generate data later

type
    LayerDense = ref object
        weights: Matrix
        biases: Vector
        output: Matrix

    ActivationReLU = ref object
        output: Matrix


proc layerDense(inputs, neurons: int, max: SomeFloat = 0.1): LayerDense =
    new result
    result.weights = randomMatrix(inputs, neurons, max)
    result.biases = zeros(neurons)
    #implementing a random negative value because Nim's random doesn't do it (like Numpy)
    #i'm not quite sure yet if this is going to cause problems down the road
    for r,vec in result.weights: #DO BETTER IMPLEMENTATION... was in a rush
        for c,val in vec:
            if rand(1) == 0:
                result.weights[r][c] = -result.weights[r][c]

proc activation_ReLU(inputs, neurons: int): ActivationReLU =
    new result
    result.output = zeros(inputs, neurons)

proc forward(layer: var LayerDense, inputs: Matrix) =
    layer.output = dot(inputs, layer.weights) + layer.biases

proc forward(activationObj: var ActivationReLU, layerOutput: Matrix) =
    for r,vec in layerOutput: #DO BETTER IMPLEMENTATION... was in a rush
        for c,val in vec:
            activationObj.output[r][c] = max(0,layerOutput[r][c])

proc inputsQty(mtrx: Matrix): int = #probably not even necessary
    return mtrx.len

proc neuronsQty(layer: LayerDense): int = #probably not even necessary
    return layer.biases.len

var
    layer1 = layerDense(2,5)
    activation1 = activationReLU(inputsQty(X), neuronsQty(layer1))
                 
layer1.forward(X)
activation1.forward(layer1.output)
echo activation1.output