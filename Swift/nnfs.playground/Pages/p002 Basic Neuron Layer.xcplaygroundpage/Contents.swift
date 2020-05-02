//: [Previous](@previous)

/*
Creates a simple layer of neurons, with 4 inputs.
---
[Associated YT NNFS tutorial](https://www.youtube.com/watch?v=lGLto9Xd7bU)
*/

import Surge


let inputs = [1.0, 2.0, 3.0, 2.5]

let weights1 = [0.2, 0.8, -0.5, 1.0]
let weights2 = [0.5, -0.91, 0.26, -0.5]
let weights3 = [-0.26, -0.27, 0.17, 0.87]

let bias1 = 2.0
let bias2 = 3.0
let bias3 = 0.5

let output = [Surge.sum(inputs .* weights1) + bias1,
             Surge.sum(inputs .* weights2) + bias2,
             Surge.sum(inputs .* weights3) + bias3]

print(output)

//: [Next](@next)
