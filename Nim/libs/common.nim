# NOTES:
#
# - review procs for more potential func/{.nosideeffects.} uses
# - inline procedures after profiling bottlenecks
# - add dimension checks & other exception handling
# - use zip where/when applicable in procs & improve readability/performance
# - use algorithm and stats modules where/when applicable to improve readability/performance
# -

import random, sequtils, math, strutils, algorithm, stats

randomize() # inits default random number generator

# the Vector/Matrix types are simply aliases and are treated the same as normal seqs
type
    Vector* = seq[float]
    Matrix* = seq[seq[float]]
    
func vector*(s: seq[float]): Vector = # can also simply declare type within variable assignment
    return s

func vector*(data: varargs[float]): Vector =
    return @data

proc randomVector*(len: int, max: float = 1.0): Vector =
    return newSeqWith(len, rand(max))

func matrix*(s: seq[seq[float]]): Matrix = # can also simply declare type within variable assignment
    return s

proc randomMatrix*(rows, cols: int, max: float = 1.0): Matrix =
    return newSeqWith(rows, newSeqWith(cols, rand(max)))

proc zeros*(len: int): Vector =
    return newSeqWith(len, 0.0)

proc zeros*(rows, cols: int): Matrix =
    return newSeqWith(rows, newSeqWith(cols, 0.0))

func column*(m: Matrix, col: int): Vector = # returns single column in Matrix
    for i in 0 .. m.high:
        result.add(m[i][col])

proc t*(m: var Matrix) = # transpose Matrix
    var s: seq[seq[float]]
    for i in 0 .. m[0].high:
        s.add(m.column(i))
    m = s

func `dot`*(v1, v2: Vector): float = # v * v dot product
    var s: seq[float]
    for i,val in v1:
        s.add(val * v2[i])
    return s.foldl(a + b)

func `dot`*(m: Matrix, v: Vector): Vector = # m * v dot product
    for vec in m:
        result.add(dot(vec, v))

proc `dot`*(m1, m2: Matrix): Matrix = # m * m dot product
    var tmp: seq[float]
    for r in 0 .. m1.high:
        for c in 0 .. m2[0].high:
            tmp.add(dot(m1[r], m2.column(c)))
        result.add(tmp)
        tmp.delete(0,tmp.high)

func `+`*(v1, v2: Vector): Vector =
    for i,val in v1:
        result.add(val + v2[i])

func `+`*(m: Matrix, v: Vector): Matrix =
    var s: seq[Vector]
    for r in 0 .. m.high:
        s.add(m[r] + v)
    for vec in s:
        result.add(vec)

proc `/`*(v1: Vector, val: float): Vector =
    result = v1.mapIt(it / val)

proc exp*(v1: Vector): Vector = # exponentiation
    result = v1
    result.applyIt(exp(it))

proc `*`*(m1, m2: Matrix): Matrix = # Element-wise multiplication of M * M
    var vec: seq[float]
    for r in 0 .. m1.high:
        for c in 0 .. m2[0].high:
            vec.add(m1[r][c] * m2[r][c])
        result.add(vec)
        vec.delete(0,vec.high)

proc `sum`*(m: Matrix, axis: int = 1): Vector  = # UPDATE - handle other axis
    if axis != 1:
        raise ValueError.newException("for now, axis must be (1) for this proc")
    for s in m:
        result.add(s.foldl(a+b))


# helper procs
proc echo*(data: Vector) =
    var output = $data
    output = output.multiReplace((","," "),("@",""))
    echo output

proc echo*(data: Matrix) =
    var output: string
    echo "["
    for vec in data:
        output = $vec
        output = output.multiReplace((","," "),("@",""))
        echo "  ", output
    echo "]"