/**
 * Creates a simple layer of neurons, with 4 inputs.
 * Associated YT NNFS tutorial: https://www.youtube.com/watch?v=lGLto9Xd7bU
 */

val inputs = listOf(1.0, 2.0, 3.0, 2.5)

val weights1 = listOf(0.2, 0.8, -0.5, 1.0)
val weights2 = listOf(0.5, -0.91, 0.26, -0.5)
val weights3 = listOf(-0.26, -0.27, 0.17, 0.87)

val bias1 = 2
val bias2 = 3
val bias3 = 0.5


 val outputs = listOf(inputs[0] * weights1[0] + inputs[1] * weights1[1] + inputs[2] * weights1[2] + inputs[3] * weights1[3] + bias1,
                      inputs[0] * weights2[0] + inputs[1] * weights2[1] + inputs[2] * weights2[2] + inputs[3] * weights2[3] + bias2,
                      inputs[0] * weights3[0] + inputs[1] * weights3[1] + inputs[2] * weights3[2] + inputs[3] * weights3[3] + bias3)
println(outputs)
