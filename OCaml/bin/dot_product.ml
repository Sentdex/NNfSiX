let dot_product input weights bias =
  Array.map2 ( *. ) input weights
  |> Array.fold_left ( +.) bias

let inputs = [|1.0; 2.0; 3.0; 2.5|]

let weights = [|[|0.2; 0.8; -0.5; 1.0|];
               [|0.5; -0.91; 0.26; -0.5|];
               [|-0.26; -0.27; 0.17; 0.87|]|]

let bias = [|2.0; 3.0; 0.5|]

let do_all inputs weights bias =
  Array.map2 (fun w b -> dot_product inputs w b)  weights bias

let () = print_endline @@ [%show: float array]  @@ do_all inputs weights bias
