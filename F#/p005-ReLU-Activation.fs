open MathNet.Numerics.LinearAlgebra
open nnfs

let X, y = spiral_data 100 3

type LayerDense(nInputs : int, nNeurons : int) = 
    let weights: Matrix<float> = 0.1 * DenseMatrix.random nInputs nNeurons NormalDistribution
    let biases:  Vector<float> = DenseVector.zero nNeurons

    member _.Forward inputs = 
        Matrix.AddVectorToEachRow (inputs * weights) biases 


type ActivationReLU() =
    static member Forward = Matrix.map (max 0.0)

let layer1 = LayerDense(2, 5)

printfn "%A" (ActivationReLU.Forward << layer1.Forward <| X)