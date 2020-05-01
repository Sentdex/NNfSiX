/*
Doing dot product with a layer of neurons and multiple inputs
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
*/
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

        var resultArray: [Double] = []
        for lval in self{
            guard let dotProduct = lval.dot(rval) else {
                return nil
            }
            resultArray.append(dotProduct)
        }
        
        return resultArray
    }
}
// The above replaces numpy =========

let inputs:[Double] = [1.0, 2.0, 3.0, 2.5]
let weights:[[Double]] = [[0.2, 0.8, -0.5, 1.0],
                          [0.5, -0.91, 0.26, -0.5],
                          [-0.26, -0.27, 0.17, 0.87]]

let biases:[Double] = [2.0, 3.0, 0.5]

guard let output:[Double] = weights.dot(inputs)?.add(biases) else {
    fatalError("Unmatched shapes")
}
print(output)