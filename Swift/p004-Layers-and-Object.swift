/*
Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
*/
import GameKit

let rs = GKLinearCongruentialRandomSource()
rs.seed = 0
let rd = GKGaussianDistribution(randomSource: rs, mean: 0, deviation: Float(UInt8.max))

extension Array where Element == Double {
    func dot (_ rval: [Double]) -> Double? {
        if self.count != rval.count { return nil }
        return zip(self, rval).reduce(0.0, { (sum, tuple) -> Double in
            sum + tuple.0 * tuple.1
        })
    }

    func add(_ rval: [Double]) -> [Double]? {
        if self.count != rval.count { return nil }
        return zip(self, rval).map(+)
    }
}

extension Array where Element == [Double] {
    func dot (_ rval: [Double]) -> [Double]? {
        let rc = rval.count
        if self.reduce(false, { $1.count != rc }) { return nil }

        return self.map { (lval) -> Double in lval.dot(rval)! }
    }
    
    func dot (_ rval: [[Double]]) -> [[Double]]? {
        if(rval.count != self[0].count) { return nil }

        let rt = rval.T
        return zip(self.indices, self).map{ (index, row) -> [Double] in rt.dot(row)! }
    }
    
    func add(_ rval: [Double]) -> [[Double]]? {
        if self[0].count != rval.count { return nil }
        
        return self.map{ row in zip(row, rval).map(+) }
    }
    
    var T: [[Double]] {
        get {
            var out: [[Double]] = []
            let x = self.count
            let y = self[0].count
            let N = x > y ? x : y
            let M = y < x ? y : x
            for n in 0..<N {
                for m in 0..<M {
                    let a = x > y ? n : m
                    let b = y < x ? m : n
                    if out.count <= b {
                        out.append([])
                    }
                    out[b].append(self[a][b])
                }
            }
            return out
        }
    }
}
// The above replaces numpy =========

let X = [[1.0, 2.0, 3.0, 2.5],
              [2.0, 5.0, -1.0, 2.0],
              [-1.5, 2.7, 3.3, -0.8]]

class LayerDense {
    public var output: [[Double]]
    public var weights: [[Double]]
    public var biases: [Double]
    
    init(n_inputs: Int, n_neurons: Int) {
        weights = (0..<n_inputs).map { _ in
            (0..<n_neurons).map { _ in Double(rd.nextUniform()) * 0.1 }
        }
        biases = Array(repeating: 0.0, count: n_neurons)
        output = Array(repeating: [], count: n_neurons)
    }
    
    func forward(inputs: [[Double]]) {
        output = inputs.dot(weights)!.add(biases)!
    }
}

let layer1 = LayerDense(n_inputs: 4, n_neurons: 5)
let layer2 = LayerDense(n_inputs: 5, n_neurons: 2)

layer1.forward(inputs: X)
layer2.forward(inputs: layer1.output)
print(layer2.output)
