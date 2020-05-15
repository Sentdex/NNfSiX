open Nnfsix_utils

(* Creating two different modules for each type of layer *)
module Dense = struct
  type parameter = {weights: float array array; biases: float array}

  let init n_inputs n_neurons =
    {weights = rand_2d n_neurons n_inputs 0.1; biases = zeros n_neurons}

  let forward {weights; biases} inputs =
    Array.map2 (dot_product inputs) weights biases
end

module Activation_relu = struct
  let forward = Array.map (max 0.)
end

let () = Random.self_init ()

let layer1_params = Dense.init 2 5

let print_output output = output |> [%show: float array list] |> print_endline

(* We have several options here. Here is the closest way from part 4 we could imagine.
 * Note that Dense.forward has type Dense.parameter -> float array -> float array,
 * while Dense.forward has type float array -> float array
 * - Relu layers have no parameters *)
let manual_apply x = x
       |> List.map @@ Dense.forward layer1_params
       |> List.map @@ Activation_relu.forward

(* We can also note that a layer is nothing more than a
 * float array -> float array function - it takes a float array
 * as input and returns a float array (considering parameters as part of a dense layer)
 * So let's write a function that apply a bunch of layers to a (batch of) input *)
type layer = float array -> float array
type batch = float array list

let batch_apply (network: layer list) (input: batch): batch =
  List.fold_left (* for every layer from left to right *)
    (fun intermediate layer -> List.map layer intermediate) (* we apply layer to each element
                                                               in the batch*)
    input (*Starting from input *)
    network

(* This is our network - the exact same network as above. it has type layer list 
 * The first element is obtained by partially applying layer1_params (which has type Dense.parameter)
 * to Dense.forward: Dense.parameter -> float array -> float array
 * yielding a function of the desired type : float array -> float array *)
let network = [Dense.forward layer1_params; Activation_relu.forward]

let x, _ = spiral_data 100 3

let () = print_endline "Manual apply"
let () = x
         |> manual_apply
         |> print_output

let () = print_newline (); print_endline "Apply as list of layers"

let () = x
         |> batch_apply network
         |> print_output
