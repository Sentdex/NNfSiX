// Associated YT tutorial: https://youtu.be/TEWy9vZcxW4

// Since there is no good numpy equivelant library for tensor operations
// I think we will have to use Tensorflow for the Swift versions of these tutorials

import TensorFlow

var X: Tensor<Float> = [[1, 2, 3, 2.5],
                        [2.0, 5.0, -1.0, 2.0],
                        [-1.5, 2.7, 3.3, -0.8]]

struct layerDense {
    var weights: Tensor<Float>
    var biases: Tensor<Float>
    var output: Tensor<Float>

    public init(
        _ nInputs: Int,
        _ nNeurons: Int
    ) {
        self.weights = 0.10 * Tensor<Float>(randomNormal: [nInputs, nNeurons])
        self.biases = Tensor<Float>(zeros: [1, nNeurons])
        self.output = [0]
    }

    public mutating func forward(_ inputs: Tensor<Float>) -> () {
        // Unicode • == matrix multiplication
        // Compose + . + = (Note, if you are on linux you will need to bind a compose key)
        self.output = (inputs • weights) + biases
    }
}

var layer1 = layerDense(4, 5)
var layer2 = layerDense(5, 2)

layer1.forward(X)
// print(layer1.output)
layer2.forward(layer1.output)
print(layer2.output)


