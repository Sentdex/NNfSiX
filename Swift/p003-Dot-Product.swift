extension Array where Element == [Double] {
    func dot (_ rval: [Double]) -> [Double] {
        // here one should check for lvals[n].count == rval.count
        // but this will be left out for simplicity and readability
        return self.map { (lval) -> Double in lval.dot(rval) }
    }
}

extension Array where Element == Double {
    func dot (_ rval: [Double]) -> Double {
        // here one should check for lval.count == rval.count
        // but this will be left out for simplicity and readability
        return zip(self, rval)
            .reduce(0.0, { (sum, tuple) -> Double in sum + tuple.0 * tuple.1 })
    }

    // here one should check for self.count == rval.count
    // but this will be left out for simplicity and readability
    func add(_ rval: [Double]) -> [Double] {
        return zip(self, rval).map(+)
    }
}

// The above replaces the `import numpy as np` =========

var inputs:[Double] = [1.0, 2.0, 3.0, 2.5]
var weights:[[Double]] = [[0.2, 0.8, -0.5, 1.0],
                          [0.5, -0.91, 0.26, -0.5],
                          [-0.26, -0.27, 0.17, 0.87]]

var biases:[Double] = [2.0, 3.0, 0.5]

var output:[Double] = weights.dot(inputs).add(biases)
print(output)