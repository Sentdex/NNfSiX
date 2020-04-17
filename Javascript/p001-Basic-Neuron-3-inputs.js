/**
 * Create basic neuron with 3 inputs in Javascript.
 */

let inputs = [1.2, 5.1, 2.1];
let weights = [3.1, 2.1, 8.7];
let bias = 3.0
let output = inputs[0] * weights[0] +
    inputs[1] * weights[1] +
    inputs[2] * weights[2] +
    bias;

console.log(`Predict : ${output}`)