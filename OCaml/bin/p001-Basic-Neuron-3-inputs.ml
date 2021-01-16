let input = [|1.; 2.; 3.|]
let weights = [|3.1; 2.1; 8.7|]
let bias = 3.0

let ( * ) = ( *. )
let ( + ) = ( +. )

let output = input.(0) * weights.(0) + input.(1) * weights.(1) + input.(2) * weights.(2) + bias
           

let () = print_endline @@ string_of_float output
