/**
playground instructions: copy this file into your playground and the nnfs and numpy_extensions files into the Sources/ folder.
*/

let (X, y) = NNfS.spiral_data(points: 100, classes: 3)

class LayerDense {
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


let layer1 = LayerDense(n_inputs: 2, n_neurons: 5)
let activation1 = ReLU()

layer1.forward(inputs: X)

//print(layer1.output)
activation1.forward(inputs: layer1.output)
print(activation1.output)
