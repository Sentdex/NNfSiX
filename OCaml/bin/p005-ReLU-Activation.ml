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

let zip a1 a2 = List.map2 (fun t1 t2 -> t1, t2) a1 a2 

let unzip a = List.fold_right (fun (t1, t2) (a1, a2) -> t1::a1, t2::a2)  a ([], [])

(*
 * #https://cs231n.github.io/neural-networks-case-study/
def spiral_data(points, classes):
    X = np.zeros((points*classes, 2))
    y = np.zeros(points*classes, dtype='uint8')
    for class_number in range(classes):
        ix = range(points*class_number, points*(class_number+1))
        r = np.linspace(0.0, 1, points)  # radius
        t = np.linspace(class_number*4, (class_number+1)*4, points) + np.random.randn(points)*0.2
        X[ix] = np.c_[r*np.sin(t*2.5), r*np.cos(t*2.5)]
        y[ix] = class_number
    return X, y
 * *)
let linspace start end_ num = match num with
  | 0 -> [||]
  | 1 -> [|start|]
  | n -> Array.init n (fun i -> start +. (float_of_int i) *. (end_ -. start) /. (float_of_int @@ n  - 1))

let spiral_data points classes =
  let init_subarray class_number =
    let r = linspace 0. 1. points
    and t = Array.map2
        (+.)
        (linspace (float_of_int @@ class_number * 4) (float_of_int @@ (class_number + 1) * 4) points)
        (rand_1d points 0.2) in
    Array.map2 (fun r t -> [|r *. (sin (2.5 *. t)); r *. (cos (2.5 *. t))|]) r t, Array.make points class_number
  in
  List.init classes init_subarray
  |> unzip
  |> fun (x, y) -> Array.to_list @@ Array.concat x, Array.concat y

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
       |> List.map Activation_relu.forward

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
