(*
    Doing dot product with a layer of neurons and multiple inputs
    Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
*)

open NumSharp
(*
    NumSharp is a NumPy port for .NET
    https://github.com/SciSharp/NumSharp
    https://www.nuget.org/packages/NumSharp/
*)

(* inputs and weights have to be mutable so we can get their address
   since they are 'top-level' values *)
let mutable inputs  = NDArray [|1.0; 2.0; 3.0; 2.5|]
let mutable weights = NDArray [|[|  0.2;   0.8; -0.5;  1.0|]
                                [|  0.5; -0.91; 0.26; -0.5|]
                                [|-0.26; -0.27; 0.17; 0.87|]|]

let biases = NDArray [|2.0; 3.0; 0.5|]

let output = np.dot(&weights, &inputs) + biases

System.Console.WriteLine output
