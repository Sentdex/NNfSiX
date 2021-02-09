(*
    Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
*)

open NumSharp
(*
    NumSharp is a NumPy port for .NET
    https://github.com/SciSharp/NumSharp
    https://www.nuget.org/packages/NumSharp/
*)

let X = NDArray [|[| 1.0; 2.0;  3.0;  2.5|]
                  [| 2.0; 5.0; -1.0;  2.0|]
                  [|-1.5; 2.7;  3.3; -0.8|]|]

type LayerDense(nInputs : int, nNeurons : int) = 
    let weights = 0.1 * np.random.randn [|nInputs; nNeurons|]
    let biases  = np.zeros [|1; nNeurons|]

    member _.Forward inputs = 
        np.dot(&inputs, &weights) + biases

let layer1 = LayerDense(4, 5)
let layer2 = LayerDense(5, 2)

System.Console.WriteLine (layer2.Forward << layer1.Forward <| X)
