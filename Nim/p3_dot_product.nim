# understanding the "dot product"
# video ref: https://youtu.be/tMrbN67U9d4

import neo
# Nim's equivalent to Python's Numpy (linear algebra operations)
# repo: https://github.com/unicredit/neo
# we're using BLAS operations from wrapped BLAS libraries
# ref: https://github.com/unicredit/neo#blas-operations

let
    inputs = vector([1.0, 2.0, 3.0, 2.5])
    weights = matrix(@[
        @[0.2, 0.8, -0.5, 1.0],
        @[0.5, -0.91, 0.26, -0.5],
        @[-0.26, -0.27, 0.17, 0.87]])

    biases = vector([2.0, 3.0, 0.5])


proc dotProduct(weights :Matrix, inputs, biases :Vector) :Vector =
    result = weights * inputs
        # the `*` operation w/ Neo can get:
        #   - dot product of two Vectors
        #   - Matrix-Vector product
        #   - Matrix-Matrix product
    result += biases # the `+` operation can work w/ 2 Matrix or 2 Vectors


var output = weights.dotProduct(inputs, biases=biases)

echo output
# [4.8, 1.21, 2.385]