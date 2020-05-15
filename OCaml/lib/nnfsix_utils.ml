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

let map2 f (x, y) = f x , f y

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
