//: [Previous](@previous)

/*
Creates a basic neuron with 3 inputs.

Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
*/
import Surge

let inputs = [1.2, 5.1, 2.1]
let weights = [3.1, 2.1, 8.7]
let bias = 3.0

let output = Surge.sum(inputs .* weights) + bias

print(output)

//: [Next](@next)
