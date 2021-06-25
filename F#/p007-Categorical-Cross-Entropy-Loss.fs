(*
  Calculating the loss with Categorical Cross Entropy
  Associated with YT NNFS tutorial: https://www.youtube.com/watch?v=dEXPMQXoiLc
*)

open type System.Math

let softmax_output = [0.7; 0.1; 0.2]
let target_output  = [1; 0; 0]

let loss = -(Log(softmax_output.[0]) * float target_output.[0] + 
             Log(softmax_output.[1]) * float target_output.[1] +
             Log(softmax_output.[2]) * float target_output.[2])
           
printfn "%f" loss

printfn "%f" (-Log 0.7)
printfn "%f" (-Log 0.5)
