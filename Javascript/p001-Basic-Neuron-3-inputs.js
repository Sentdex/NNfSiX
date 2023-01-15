/**
 * Create basic neuron with 3 inputs in Javascript.
 */

const inputs  = [1.2, 5.1, 2.1];
const weights = [3.1, 2.1, 8.7];
const bias    = 3;

const output = inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias;

console.log(output);
