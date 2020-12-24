import Foundation
// The below replaces numpy in the pythonic examples =========

extension Array where Element == Double {
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
    
    public func add (_ rval: [Double]) -> [[Double]]? {
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

let π = Double.pi

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
