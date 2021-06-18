# understanding batches, layers, objects
# video ref: https://youtu.be/TEWy9vZcxW4

import libs/common

type
    LayerDense = ref object
        weights: Matrix
        biases: Vector
        output: Matrix

proc layerDense(inputs, neurons: int, max: SomeFloat = 0.1): LayerDense =
    new result
    result.weights = randomMatrix(inputs, neurons, max)# no need for transposing since we control the initialization
    result.biases = zeros(neurons)

proc forward(layer: LayerDense, inputs: Matrix) =
    layer.output = dot(inputs, layer.weights) + layer.biases


var X = matrix(@[
    @[1.0, 2.0, 3.0, 2.5],
    @[2.0, 5.0, -1.0, 2.0],
    @[-1.5, 2.7, 3.3, -0.8]])

var
    layer1 = layerDense(4,5)
    layer2 = layerDense(5,2)

layer1.forward(X)
layer2.forward(layer1.output)

echo layer2.output

# ---------- The code below is for the tutorial before creating objects ----------

# var
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

# weights.t
# var layer1_outputs = dot(inputs, weights) + biases
# weights2.t
# var layer2_outputs = dot(layer1_outputs, weights2) + biases2
# echo layer2_outputs
#  #layer2_outputs:
# # [ [ 0.5030999999999999  -1.04185        -2.03875 ]
# #   [ 0.2434000000000003  -2.7332 -5.763300000000001 ]
# #   [ -0.99314    1.41254 -0.3565500000000003 ] ]