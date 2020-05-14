module nnfs

open MathNet.Numerics
open MathNet.Numerics.LinearAlgebra

// Just a normal distribution
let NormalDistribution = Distributions.Normal(Random.SystemRandomSource.Default)

// A method instead of operator overloading due to some constraints of F#
module Matrix = 
    let AddVectorToEachRow(m : Matrix<float>) (v : Vector<float>) = Matrix.mapRows (fun _ row -> row + v) m

let spiral_data points classes =
    let X = DenseMatrix.zero<float> (points * classes) 2
    let y = DenseVector.zero<float> (points * classes)

    for classNumber in [0..classes-1] do
        let r = vector (Generate.LinearSpaced(points, 0.0, 1.0))
        let t = vector (Generate.LinearSpaced(points, float (classNumber*4), float ((classNumber + 1) * 4))) + (DenseVector.random points NormalDistribution) * 0.2

        let sv = Vector.map2 (fun a b -> sin (a * 2.5) * b) t r
        let cv = Vector.map2 (fun a b -> cos (a * 2.5) * b) t r

        for j, i in List.indexed [points*classNumber..points*(classNumber + 1) - 1] do
            X.[i, 0] <- sv.[j]
            X.[i, 1] <- cv.[j]
            y.[i] <- float classNumber
    X, y