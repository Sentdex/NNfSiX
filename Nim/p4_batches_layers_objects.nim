# understanding batches, layers, objects
# video ref: https://youtu.be/TEWy9vZcxW4

import neo

let
    X = matrix(@[
        @[1.0, 2.0, 3.0, 2.5],
        @[2.0, 5.0, -1.0, 2.0],
        @[-1.5, 2.7, 3.3, -0.8]])


type
    LayerDense = ref object
        weights :Matrix[float64]
        biases :Vector[float64]
        output :Matrix[float64]

proc initLayerDense(inputs, neurons :int) :LayerDense =
    new result
    result.weights = randomMatrix(inputs, neurons, max=0.10)# no need for transposing since we control the initialization
    result.biases = zeros(neurons)

proc forward(layer :LayerDense, inputs :Matrix[float64]) =
    layer.output = inputs * layer.weights
    for i,val in layer.output: #adds biases value by value in the matrix, haven't better solution
        layer.output[i[0],i[1]] = layer.output[i[0],i[1]] + layer.biases[i[1]]

var
    layer1 = initLayerDense(4,5)
    layer2 = initLayerDense(5,2)

layer1.forward(X)
layer2.forward(layer1.output)

echo layer2.output


# ---------- The code below is for the tutorial before creating objects ----------

# let
#     inputs = matrix(@[
#         @[1.0, 2.0, 3.0, 2.5],
#         @[2.0, 5.0, -1.0, 2.0],
#         @[-1.5, 2.7, 3.3, -0.8]])

#     weights = matrix(@[
#         @[0.2, 0.8, -0.5, 1.0],
#         @[0.5, -0.91, 0.26, -0.5],
#         @[-0.26, -0.27, 0.17, 0.87]])

#     biases = vector([2.0, 3.0, 0.5])

#     weights2 = matrix(@[
#         @[0.1, -0.14, 0.5],
#         @[-0.5, 0.12, -0.33],
#         @[-0.44, 0.73, -0.13]])

#     biases2 = vector([-1.0, 2.0, -0.5])


# proc dotProduct(inputs, weights :Matrix, biases :Vector) :Matrix =
#     result = inputs * weights
#     for i,val in result: #adds biases value by value in the matrix, haven't better solution
#         result[i[0],i[1]] = result[i[0],i[1]] + biases[i[1]]


# var layer1_outputs = inputs.dotProduct(weights.T, biases=biases)
# # notice `weights.T`, .T is for hard transpose & .t is for soft transpose
# # ref: https://github.com/unicredit/neo#blas-operations

# var layer2_outputs = layer1_outputs.dotProduct(weights2.T, biases=biases2)

# echo layer2_outputs
#  #layer2_outputs:
# # [ [ 0.5030999999999999  -1.04185        -2.03875 ]
# #   [ 0.2434000000000003  -2.7332 -5.763300000000001 ]
# #   [ -0.99314    1.41254 -0.3565500000000003 ] ]
