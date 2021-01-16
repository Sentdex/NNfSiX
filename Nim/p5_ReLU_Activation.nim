# understanding hidden layer activation functions (Rectified Linear Unit)
# video ref: https://youtu.be/gmjzbpSVY1A


# note:
# sorry guys, not a fan of OOP at all. The rest of the tutorials will be written procedural-style.

import neo

type
    LayerDense = ref object
        weights :Matrix[float64]
        biases :Vector[float64]
        output :Matrix[float64]

    Activation_ReLU = ref object #testing
        output :Matrix[float64]

proc initLayerDense(inputs, neurons :int) :LayerDense =
    new result
    result.weights = randomMatrix(inputs, neurons, max=0.10)
    result.biases = zeros(neurons)

proc initActivation_ReLU(inputs, neurons :int) :Activation_ReLU =
    new result
    result.output = zeros(inputs, neurons)

proc forward(layer :LayerDense, inputs :Matrix[float64]) =
    layer.output = inputs * layer.weights
    for i,val in layer.output:
        layer.output[i[0],i[1]] = layer.output[i[0],i[1]] + layer.biases[i[1]]

proc forward(activationObj :Activation_ReLU, layerOutput :Matrix[float64]) =
    for i,val in layerOutput:
        activationObj.output[i[0],i[1]] = max(0,layerOutput[i[0],i[1]])

let
    X = matrix(@[
        @[1.0, 2.0, 3.0, 2.5],
        @[2.0, 5.0, -1.0, 2.0],
        @[-1.5, 2.7, 3.3, -0.8]])

var
    layer1 = initLayerDense(4,5)
    activation1 = initActivation_ReLU(inputs=X.M, neurons=layer1.biases.len) #basically- the rows of inputs & quantity of neurons
                                    # .M gets the quantity of rows in a Matrix, .len gets the length of a Vector
layer1.forward(X)
echo layer1.output
echo "\n"
activation1.forward(layer1.output)
echo activation1.output
