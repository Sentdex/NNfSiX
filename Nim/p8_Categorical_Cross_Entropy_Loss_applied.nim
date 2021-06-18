# calculating loss from the softmax outputs!
# video ref: https://youtu.be/levekYbxauw

import libs/common, libs/dataset1, math, sequtils
from stats import mean
from random import rand

# Notes
# will be switching to OOP in future parts

type
    LayerDense = ref object
        weights: Matrix
        biases: Vector
        output: Matrix

    ActivationReLU = ref object
        output: Matrix

    ActivationSoftmax = ref object
        output: Matrix
    Loss = ref object of RootObj
    Loss_CategoricalCrossentropy = ref object of Loss

proc layerDense(inputs, neurons: int, max: SomeFloat = 0.1): LayerDense =
    new result
    result.weights = randomMatrix(inputs, neurons, max)
    result.biases = zeros(neurons)
    for r,vec in result.weights:
        for c,val in vec:
            if rand(1) == 0:
                result.weights[r][c] = -result.weights[r][c]

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

proc clipVals(m: Matrix): Matrix = # to prevent possible -ln(0)
    for vec in m:
        result.add vec.map(proc(x: float): float =
            x.clamp(1e-7, 1-1e-7)) # 1e-7 and the inverse (to remove any bias)

proc forward[T: Matrix | Vector](lossObj: Loss_CategoricalCrossentropy,
                yPred: Matrix, yTrue: T): Vector =

    var yPredClipped = yPred.clipVals
    var correctConfidences: seq[float]

    when yTrue.type is Vector:
        for r in 0 .. yPred.high:
            correctConfidences.add yPredClipped[r][yTrue[r].toInt]
    elif yTrue.type is Matrix:
        correctConfidences = sum(yPredClipped * yTrue, axis=1)

    for val in correctConfidences:
        result.add(-ln(val)) # this is negative log likelihoods

proc calculate[T: Matrix | Vector](loss: Loss_CategoricalCrossentropy,
                    output: Matrix, y: T): float =
    var sampleLosses = loss.forward(output, y)
    return mean(sampleLosses) # batch loss

proc accuracy[T: Matrix | Vector](m: Matrix, y: T): float = #use to calculate the accuracy of the softmaxoutputs
    var predictions, accuracy: seq[float]
    for vec in m:
        predictions.add(maxIndex(vec).toFloat)

    when y is Vector:
        for i, prediction in predictions:
            if prediction == y[i]: accuracy.add 1.0
            else: accuracy.add 0.0
    elif y is Matrix:
        var mToVec: seq[float]
        for vec in y:
            mToVec.add(maxIndex(vec).toFloat)
        for i, prediction in predictions:
            if prediction == mToVec[i]: accuracy.add 1.0
            else: accuracy.add 0.0

    return mean(accuracy)


var dense1 = layerDense(2,3)
var activation1 = activation_ReLU(X.len, dense1.biases.len)
var dense2 = layerDense(3,3)
var activation2 = activation_Softmax(activation1.output.len, dense2.biases.len)

dense1.forward(X)
activation1.forward(dense1.output)
dense2.forward(activation1.output)
activation2.forward(dense2.output)
echo activation2.output

var lossFunction = new Loss_CategoricalCrossentropy
var loss = lossFunction.calculate(activation2.output, y)
echo "Loss: " & $loss

# to calculate accuracy of softmax outputs:
var acc = activation2.output.accuracy(y)
echo "Accuracy: " & $acc



# ---------- tutorial before implementing classes ----------

# var
#     softmaxOutputs = matrix(@[@[0.7, 0.1, 0.2],
#                                 @[0.1, 0.5, 0.4],
#                                 @[0.02, 0.9, 0.08]])
#     classTargets = vector(@[0.0, 1.0, 1.0])

# var confidenceVals: seq[float]
# for r in 0 .. softmaxOutputs.high:
#     confidenceVals.add softmaxOutputs[r][classTargets[r].toInt]
# echo confidenceVals # @[0.7, 0.5, 0.9]

# var losses: seq[float]
# for val in confidenceVals:
#     losses.add -ln(val)
# echo losses # @[0.3566749439387324, 0.6931471805599453, 0.1053605156578263]

# var averageLoss = mean(losses)
# echo averageLoss # 0.385060880052168