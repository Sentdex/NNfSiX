/*
Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
*/

const math = require("mathjs");

const X = [
  [1, 2, 3, 2.5],
  [2.0, 5.0, -1.0, 2.0],
  [-1.5, 2.7, 3.3, -0.8],
];

class Layer_Dense {
  constructor(n_inputs, n_neurons) {
    this.weights = math.random([n_inputs, n_neurons], -1.0, 1.0);
    this.biases = math.zeros([1, n_neurons]);
  }

  forward = (inputs) => {
    // Mathjs add only supports elementwise add. So I had to create this temp_biases.
    let temp_biases = this.biases;
    let temp_biases_size = inputs.length;
    for (let i = 1; i < temp_biases_size; i++) {
      temp_biases = math.concat(temp_biases, this.biases, 0);
    }

    this.output = math.add(math.multiply(inputs, this.weights), temp_biases);
  };
}

const layer1 = new Layer_Dense(4, 5);
const layer2 = new Layer_Dense(5, 2);

layer1.forward(X);
// console.log(layer1.output);
layer2.forward(layer1.output);
console.log(layer2.output);
