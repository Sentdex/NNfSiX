# understanding softmax activation function (for output layer)
# video ref: https://youtu.be/omz_NdFgWyU

# input -> exponentiate -> normalize -> output
# Softmax Activation Function is: exponentiation -> normalize
# sum of normalizedValues should be 0.9999999999999999 for each output Vector within the Matrix

import math, libs/common, libs/dataset1
from random import rand


type
    LayerDense = ref object
        weights: Matrix
        biases: Vector
        output: Matrix

    ActivationReLU = ref object
        output: Matrix

    ActivationSoftmax = ref object
        output: Matrix


proc layerDense(inputs, neurons: int, max: SomeFloat = 0.1): LayerDense =
    new result
    result.weights = randomMatrix(inputs, neurons, max)
    result.biases = zeros(neurons)
    for r,vec in result.weights:
        for c,val in vec:
            if rand(1) == 0:
                result.weights[r][c] = -result.weights[r][c]

func inputsQty(mtrx: Matrix): int =
    return mtrx.len

func neuronsQty(layer: LayerDense): int =
    return layer.biases.len

proc activation_ReLU(inputs, neurons: int): ActivationReLU =
    new result
    result.output = zeros(inputs, neurons)

proc activation_Softmax(inputs, neurons: int): ActivationSoftmax =
    new result
    result.output = zeros(inputs, neurons)

func overflowPrevention(vec: Vector, maxVal: float): Vector =
    for val in vec:
        result.add(val - maxVal)

proc forward(activationObj: var ActivationSoftmax, layerOutput: Matrix) =
    var
        normValues: seq[seq[float64]]
        normVec: Vector
        expValues: Vector

    for row in layerOutput:
        expValues = overflowPrevention(row, max(row))
        normVec = exp(expValues) / sum(exp(expValues))
        normValues.add normVec

    activationObj.output = matrix(normValues)


proc forward(layer: var LayerDense, inputs: Matrix) =
    layer.output = dot(inputs, layer.weights) + layer.biases

proc forward(activationObj: var ActivationReLU, layerOutput: Matrix) =
    for r,vec in layerOutput:
        for c,val in vec:
            activationObj.output[r][c] = max(0,layerOutput[r][c])


var dense1 = layerDense(2,3)
var activation1 = activation_ReLU(inputsQty(X),neuronsQty(dense1))
var dense2 = layerDense(3,3)
var activation2 = activation_Softmax(inputsQty(activation1.output),neuronsQty(dense2))


dense1.forward(X)
activation1.forward(dense1.output)
dense2.forward(activation1.output)
activation2.forward(dense2.output)
echo activation2.output
echo sum(activation2.output[0]) #should equal 1 (or 0.9xxxxxxx)