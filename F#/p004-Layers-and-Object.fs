(*
    Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
*)

open MathNet.Numerics
open MathNet.Numerics.LinearAlgebra

// MathNet doesn't have a Matrix + Vector operation, so let's make it by ourselves
let inline (+) (m : Matrix<'a>) (v : Vector<'a>) = Matrix.mapRows (fun _ row -> row + v) m

let X = matrix [[ 1.0; 2.0;  3.0;  2.5]
                [ 2.0; 5.0; -1.0;  2.0]
                [-1.5; 2.7;  3.3; -0.8]]

// Normal distribution with thread-safe generator
// To specify the seed change generator to Random.SystemRandomSource(seed)
let gauss = Distributions.Normal(Random.SystemRandomSource.Default)

type LayerDense(nInputs : int, nNeurons : int) = 
    let weights: Matrix<float> = 0.1 * DenseMatrix.random nInputs nNeurons gauss
    let biases:  Vector<float> = DenseVector.zero nNeurons

    // The more 'functional' way is to have the Forward function return the output
    member _.Forward inputs = 
        inputs * weights + biases

let layer1 = LayerDense(4, 5)
let layer2 = LayerDense(5, 2)

printfn "%A" (layer2.Forward << layer1.Forward <| X)