let inputs = [|1.0; 2.0; 3.0; 2.5|]

let weights1 = [|0.2; 0.8; -0.5; 1.0|]
let weights2 = [|0.5; -0.91; 0.26; -0.5|]
let weights3 = [|-0.26; -0.27; 0.17; 0.87|]

let ( * ) = ( *. )
let ( + ) = ( +. )

let bias1 = 2.0
let bias2 = 3.0
let bias3 = 0.5

let output = [
  inputs.(0) * weights1.(0) + inputs.(1) * weights1.(1) + inputs.(2) * weights1.(2) + bias1;
  inputs.(0) * weights2.(0) + inputs.(1) * weights2.(1) + inputs.(2) * weights2.(2) + bias2;
  inputs.(0) * weights3.(0) + inputs.(1) * weights3.(1) + inputs.(2) * weights3.(2) + bias3;
]

