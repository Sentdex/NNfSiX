import GameKit
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
        let exp_values = inputs.map { row -> [Double] in
            guard let max_value = row.max() else {
                fatalError("invalid inputs")
            }
            return row.map { value in
                exp(value - max_value)
            }
        }
        
        self.output = exp_values.map { row in row.div(row.reduce(0,+)) }
    }
}

protocol Loss {
    func forward(y_pred:[[Double]], y_true:[Int]) -> [Double]
    func forward(y_pred:[[Double]], y_true:[[Int]]) -> [Double]
}

extension Loss {
    func calculate(output:[[Double]], y:[Int]) -> Double {
        let sample_losses = self.forward(y_pred: output, y_true: y)
        let data_loss = sample_losses.mean
        return data_loss
    }
    func calculate(output:[[Double]], y:[[Int]]) -> Double {
        let sample_losses = self.forward(y_pred: output, y_true: y)
        let data_loss = sample_losses.mean
        return data_loss
    }
}

class Loss_CategoricalCrossentropy: Loss {
    public func forward(y_pred:[[Double]], y_true:[Int]) -> [Double] {
        let samples = y_pred.count
        let y_pred_clipped = y_pred.clip(to:1e-7...1-1e-7)

        let correct_confidences = zip(Array(0...samples), y_true).map{ (x,y) in
            y_pred_clipped[x][y]
        }
        
        let negative_log_likelihoods = correct_confidences.map{ el in -log(el) }
        return negative_log_likelihoods
    }

    public func forward(y_pred:[[Double]], y_true:[[Int]]) -> [Double] {
        let y_pred_clipped = y_pred.clip(to:1e-7...1-1e-7)

        let correct_confidences: [Double] = y_true
            .map{ y_pred_clipped[$0.first!][$0.last!] }
        
        let negative_log_likelihoods = correct_confidences.map{ el in -log(el) }
        return negative_log_likelihoods
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

print(activation2.output.prefix(5))

let loss_function = Loss_CategoricalCrossentropy()
let loss = loss_function.calculate(output: activation2.output, y: y.map(Int.init))

print("Loss:", loss)

public class NNfS {
    static public let rs = GKLinearCongruentialRandomSource(seed: 0)
    static public let rd = GKGaussianDistribution(randomSource: rs, mean: 0, deviation: Float(UInt8.max))

    // https://cs231n.github.io/neural-networks-case-study/
    static public func spiral_data(points:Int, classes:Int) -> ([[Double]], [UInt8]) {
        let height = points * classes
        var X:[[Double]] = [[Double]](count: height, generating: { _ in [Double](repeating: 0.0, count: 2) })
        var y:[UInt8] = [UInt8](repeating: 0, count: points*classes)
        
        for classNumber in 0..<classes {
            let ix = points*classNumber..<points*(classNumber+1)

            let r = Array(count: points, generating: { n in Double(n)/Double(points) }) // radius
                        
            let tl = Array(count: points, generating: { n -> Double in Double(n)/Double(points) * 4.0 + Double(classNumber) })
            let tr = Array(count: points, generating: { _ in Double(rd.nextUniform()) * 0.2 })
            let t = tl.add(tr)!
                                    
            let rSin:[Double] = r.mul(sin(radians: t.mul(2.5)))!
            let rCos:[Double] = r.mul(cos(radians: t.mul(2.5)))!
            let xSub = rSin.concatHorizontal(rCos)
                        
            X.replaceSubrange(  ix, with: xSub )
            y.replaceSubrange(  ix, with: Array<UInt8>(repeating: UInt8(classNumber), count: ix.count) )
        }

        return (X, y)
    }
}

extension Array {
     /// Create a new Array whose values are generated by the given closure.
     /// - Parameters:
     ///     - count:            The number of elements to generate
     ///     - elementGenerator: The closure that generates the elements.
     ///                         The index into which the element will be
     ///                         inserted is passed into the closure.
    public init(count: Int, generating elementGenerator: (Int) -> Element) {
        self = (0..<count).map(elementGenerator)
    }
}

// The below replaces numpy in the pythonic examples =========

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

extension Array where Element: BinaryInteger {
    var mean: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }
}

extension Array where Element: BinaryFloatingPoint {
    var mean: Double {
        if self.isEmpty {
            return 0.0
        } else {
            let sum = self.reduce(0, +)
            return Double(sum) / Double(self.count)
        }
    }
}

extension Array where Element == Double {
    public func clip (to limits: ClosedRange<Double>) -> Self {
        let r = self
        return r.map{ row in
            row.clamped(to: limits)
        }
    }
    
    public func dot (_ rval: [Double]) -> Double? {
        if self.count != rval.count { return nil }
        return zip(self, rval).reduce(0.0, { (sum, tuple) -> Double in
             sum + tuple.0 * tuple.1
        })
    }

    public func concatHorizontal(_ rval: [[Double]]) -> [[Double]] {
        return self.T.concatHorizontal(rval)
    }

    public func concatHorizontal(_ rval: [Double]) -> [[Double]] {
        return self.T.concatHorizontal(rval.T)
    }

    public var T: [[Double]] {
        get {
            return self.reduce(into: []){ $0.append([$1]) }
        }
    }

    public func add(_ rval: [Double]) -> [Double]? {
        if self.count != rval.count { return nil }

        return zip(self, rval).map(+)
    }

    public func mul(_ rval: [Double]) -> [Double]? {
        if self.count != rval.count { return nil }

        return zip(self, rval).map(*)
    }

    public func div(_ rval: [Double]) -> [Double]? {
        if self.count != rval.count { return nil }

        return zip(self, rval).map(/)
    }

    public func mul(_ rval: Double) -> [Double] {
        return self.map{ lval in lval * rval }
    }

    public func div(_ rval: Double) -> [Double] {
        return self.map{ lval in lval / rval }
    }
}

extension Array where Element == [Double] {
    public func clip (to limits: ClosedRange<Double>) -> Self {
        let r = self
        return r.map{ row in
            row.map { el in
                el.clamped(to: limits)
            }
        }
    }
    
    public func dot (_ rval: [Double]) -> [Double]? {
        let rc = rval.count
        if self.reduce(false, { $1.count != rc }) { return nil }

        return self.map { (lval) -> Double in lval.dot(rval)! }
    }

    public func dot (_ rval: [[Double]]) -> [[Double]]? {
        if(rval.count != self[0].count) { return nil }

        let rt = rval.T
        return zip(self.indices, self).map{ (index, row) -> [Double] in rt.dot(row)! }
    }
    
    public func add(_ rval: [Double]) -> [[Double]]? {
        if self[0].count != rval.count { return nil }

        return self.map{ row in zip(row, rval).map(+) }
    }

    public var T: [[Double]] {
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

    public func concatHorizontal(_ rval: [[Double]]) -> [[Double]] {
        return zip(self.indices, self).map{ (index, row) in
            var next = row
            next.append(contentsOf: rval[index])
            return next
        }
    }

    public func elmul(_ rval: [[Double]]) -> [[Double]]? {
        if rval.count != self.count || rval[0].count != self[0].count { return nil }

        return zip(self, rval).map{ (lrow, rrow) in lrow.mul(rrow)! }
    }

    public func eldiv(_ rval: [[Double]]) -> [[Double]]? {
        if rval.count != self.count || rval[0].count != self[0].count { return nil }

        return zip(self, rval).map{ (lrow, rrow) in lrow.mul(rrow)! }
    }

    public func mul(_ rval: [Double]) -> [[Double]]? {
        if rval.count != self[0].count { return nil }

        return self.map{ row in row.mul(rval)! }
    }

    public func div(_ rval: [Double]) -> [[Double]]? {
        if rval.count != self[0].count { return nil }

        return self.map{ row in row.div(rval)! }
    }

    public func mul(_ rval: Double) -> [[Double]] {
        return self.map{ row in row.mul(rval) }
    }

    public func div(_ rval: Double) -> [[Double]] {
        return self.map{ row in row.div(rval) }
    }
}

public func sin(radians: [[Double]]) -> [[Double]] {
    return radians.map{ val in sin(radians: val) }
}

public func cos(radians: [[Double]]) -> [[Double]] {
    return radians.map{ val in cos(radians: val) }
}

public func sin(radians: [Double]) -> [Double] {
    return radians.map(sin)
}

public func cos(radians: [Double]) -> [Double] {
    return radians.map(cos)
}
