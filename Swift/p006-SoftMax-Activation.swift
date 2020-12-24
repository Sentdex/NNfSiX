import Foundation

let (X, y) = NNfS.spiral_data(points: 100, classes: 3)

protocol Layer {
    var output: [[Double]] { get }
    var weights: [[Double]] { get }
    var biases: [Double] { get }
    func forward(inputs:[[Double]])
}

class DenseLayer: Layer {
    public var output: [[Double]]
    public var weights: [[Double]]
    public var biases: [Double]
    
    init(n_inputs: Int, n_neurons: Int) {
        weights = (0..<n_inputs).map { _ in
            (0..<n_neurons).map { _ in Double(NNfS.rd.nextUniform()) * 0.1 }
        }
        biases = Array(repeating: 0.0, count: n_neurons)
        output = Array(repeating: [], count: n_neurons)
    }
    
    func forward(inputs: [[Double]]) {
        output = inputs.dot(weights)!.add(biases)!
    }
}

protocol Activation {
    var output: [[Double]] { get }
    func forward(inputs:[[Double]])
}

class ReLU: Activation {
    public var output: [[Double]]
    
    init() {
        output = []
    }

    public func forward(inputs:[[Double]]) {
        output = inputs.map{  row in row.map{ val in max(0, val) }  }
    }
}

class SoftMax: Activation {
    public var output: [[Double]]
    
    init() {
        output = []
    }

    public func forward(inputs:[[Double]]) {
        // exp(inputs - inputs.max)
        let exp_values = zip(inputs, inputs.map { $0.max()! })
            .map{ (input, max) in input.map { value in exp(value - max) } }
        
        // exp_values/exp_values.sum
        self.output = zip(exp_values, exp_values.map { row in row.reduce(0,+) })
            .map { (row, sum) in row.map { value in value/sum }}
    }
}


let layer1 = DenseLayer(n_inputs: 2, n_neurons: 3)
let activation1 = ReLU()

let layer2 = DenseLayer(n_inputs: 3, n_neurons: 3)
let activation2 = SoftMax()

layer1.forward(inputs: X)
activation1.forward(inputs: layer1.output)

layer2.forward(inputs: activation1.output)
activation2.forward(inputs: layer2.output)

print(activation2.output)
