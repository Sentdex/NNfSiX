(*
    Doing dot product with a layer of neurons and multiple inputs
    Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
*)

open MathNet.Numerics.LinearAlgebra
(*
    MathNet is the choice because of a nice F# support
    https://www.nuget.org/packages/MathNet.Numerics/
    https://www.nuget.org/packages/MathNet.Numerics.FSharp/
*)

let inputs  = vector [1.0; 2.0; 3.0; 2.5]
let weights = matrix [[  0.2;   0.8; -0.5;  1.0]
                      [  0.5; -0.91; 0.26; -0.5]
                      [-0.26; -0.27; 0.17; 0.87]]

let biases = vector [2.0; 3.0; 0.5]

let output = weights * inputs + biases
printfn "%A" output
