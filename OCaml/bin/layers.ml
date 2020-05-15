open Nnfsix_utils

type layers = {weights: float array array; biases: float array}

let zeros n = Array.make n 0.

let make_layer n_inputs n_neurons =
  {weights = rand_2d n_neurons n_inputs 0.1; biases = zeros n_neurons}

let forward {weights; biases} inputs =
  Array.map2 (dot_product inputs) weights biases

let x = [[|1.; 2.; 3.; 2.5|];
         [|2.0; 5.0; -1.0; 2.0|];
         [|-1.5; 2.7; 3.3; -0.8|]]

let () = Random.self_init ()

let layer1 = make_layer 4 5
let layer2 = make_layer 5 2

let () = x
       |> List.map @@ forward layer1
       |> List.map @@ forward layer2
       |> print_endline % [%show: float array list]
