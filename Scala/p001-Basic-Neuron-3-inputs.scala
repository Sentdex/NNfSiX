/*
Creates a basic neuron with 3 inputs.
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
*/

object GFG extends App
{ 

    val inputs: Array[Double] = Array(1.2, 5.1, 2.1)
    val weights: Array[Double] = Array(3.1, 2.1, 8.7)
    val bias: Double = 3.0

    val output: Double = inputs(0)*weights(0) + inputs(1)*weights(1) + inputs(2)*weights(2) + bias
    println(output)

} 