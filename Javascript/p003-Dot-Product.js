/*
Creates a simple layer of neurons using dot product.
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
*/

const math = require("mathjs");

const inputs = [1.0, 2.0, 3.0, 2.5];
const weights = math.matrix([
  [0.2, 0.8, -0.5, 1.0],
  [0.5, -0.91, 0.26, -0.5],
  [-0.26, -0.27, 0.17, 0.87],
]);

const biases = [2.0, 3.0, 0.5];

let output = math.add(math.multiply(weights, inputs), biases);
console.log(output);
