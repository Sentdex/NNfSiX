/**
 * Creates a basic neuron with 3 inputs.
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
*/

val inputs = listOf(1.2, 5.1, 2.1)
val weights = listOf(3.1, 2.1, 8.7)
val bias = 3

val output = inputs[0] * weights[0] + inputs[1] * weights[1] + inputs[2] * weights[2] + bias
println(output)
