//: [Previous](@previous)

/*
[Associated YT tutorial](https://youtu.be/TEWy9vZcxW4)
*/

import Surge
import GameKit

let rs = GKLinearCongruentialRandomSource()
rs.seed = 0
let rd = GKGaussianDistribution(randomSource: rs, mean: 0, deviation: Float(UInt8.max))

let X: Matrix<Double> = [[1, 2, 3, 2.5],
     [2.0, 5.0, -1.0, 2.0],
     [-1.5, 2.7, 3.3, -0.8]]

class LayerDense {
    public var output: Matrix<Double>
    public var weights: Matrix<Double>
    public var biases: Vector<Double>
    
    init(n_inputs: Int, n_neurons: Int) {
        weights = Matrix(rows: n_inputs, columns: n_neurons) { _,_ in Double(rd.nextUniform()) * 0.1 }
        
        biases = Vector(dimensions: n_neurons, repeatedValue: 0.0)

        output = Matrix(rows: n_neurons, columns: n_inputs, repeatedValue: 0)
    }
    func forward(inputs: Matrix<Double>) {
        output = Surge.mul(inputs, weights)
    }
}

let layer1 = LayerDense(n_inputs: 4, n_neurons: 5)
let layer2 = LayerDense(n_inputs: 5, n_neurons: 2)

layer1.forward(inputs: X)
//print(layer1.output)
layer2.forward(inputs: layer1.output)

print(layer2.output)

//: [Next](@next)
