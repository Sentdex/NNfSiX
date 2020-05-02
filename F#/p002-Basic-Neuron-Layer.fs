(*
    Creates a simple layer of neurons, with 4 inputs.
    Associated YT NNFS tutorial: https://www.youtube.com/watch?v=lGLto9Xd7bU
*)

let inputs = [1.0; 2.0; 3.0; 2.5]

let weights1 = [  0.2;   0.8; -0.5;  1.0]
let weights2 = [  0.5; -0.91; 0.26; -0.5]
let weights3 = [-0.26; -0.27; 0.17;  0.87]

let weights = [weights1; weights2; weights3]

let bias1 = 2.0
let bias2 = 3.0
let bias3 = 0.5

let biases = [bias1; bias2; bias3]

(*
let output = [inputs.[0]*weights1.[0] + inputs.[1]*weights1.[1] + inputs.[2]*weights1.[2] + inputs.[3]*weights1.[3] + bias1
              inputs.[0]*weights2.[0] + inputs.[1]*weights2.[1] + inputs.[2]*weights2.[2] + inputs.[3]*weights2.[3] + bias2
              inputs.[0]*weights3.[0] + inputs.[1]*weights3.[1] + inputs.[2]*weights3.[2] + inputs.[3]*weights3.[3] + bias3]
*)
let output = [for w, b in List.zip weights biases -> List.fold2 (fun a i w -> a + i * w) b inputs w]

printfn "%A" output