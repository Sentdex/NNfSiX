let (%) g f x = g (f x)

let zeros n = Array.make n 0.

let rand_1d n bound =
  Array.init n @@ fun _ -> Random.float bound

let rand_2d nx ny bound = 
  Array.init nx
    (fun _ -> rand_1d ny bound)

let dot_product input weights bias =
  Array.map2 ( *. ) input weights
  |> Array.fold_left (+.) bias

type layers = {weights: float array array; biases: float array}

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
