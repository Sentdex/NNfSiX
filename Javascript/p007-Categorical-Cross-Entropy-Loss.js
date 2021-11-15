/*
* Calculating the loss with Categorical Cross Entropy
* Associated with YT NNFS tutorial: https://www.youtube.com/watch?v=dEXPMQXoiLc
*/

softmax_output = [0.7, 0.1, 0.2]
target_output = [1, 0, 0]

loss = -(math.log(softmax_output[0]) * target_output[0] +
         math.log(softmax_output[1]) * target_output[1] +
         math.log(softmax_output[2]) * target_output[2])

console.log(loss)

console.log(-math.log(0.7))
console.log(-math.log(0.5))
