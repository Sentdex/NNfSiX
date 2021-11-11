/* This is a javascript implementation of neural networks from scratch in python  series.
*
*The part 6 bits i.e Softmax activation struct is declared and defined after line 718
*
* Link to the series on youtube: https://www.youtube.com/watch?v=Wo5dMEP_BbI&list=PLQVvvaa0QuDcjD5BAw2DxE6OF2tius3V3
*/

const math = require("mathjs");

// Moved this code from spiral-data.js written by @vancegillies
// Updated by @daniel-kukiela
function spiral_data(points, classes) {
  // Using MathJs functions to make matrices with zeros but converting to arrays for simplicity
  const X = math.zeros(points * classes, 2).toArray();
  const y = math.zeros(points * classes, "dense").toArray();
  let ix = 0;
  for (let class_number = 0; class_number < classes; class_number++) {
    let r = 0;
    let t = class_number * 4;

    while (r <= 1 && t <= (class_number + 1) * 4) {
      // adding some randomness to t
      const random_t = t + math.random(points) * 0.008;
      // Was `* 0.2` but reduced so you can somewhat see the arms of spiral in visualization
      // Fell free to change it back

      // converting from polar to cartesian coordinates
      X[ix][0] = r * math.sin(random_t * 2.5);
      X[ix][1] = r * math.cos(random_t * 2.5);
      y[ix] = class_number;

      // the below two statements achieve linspace-like functionality
      r += 1.0 / (points - 1);
      t += 4.0 / (points - 1);

      ix++; // increment index
    }
  }
  // Returning as MathJs matrices, could be arrays, doesnt really matter
  return [math.matrix(X), math.matrix(y)];
}

let [X, y] = spiral_data(100, 3);





// no randn equivalent in JS, so boxMueller transform necessary to pull appropriate values from normal distribution
// https://stackoverflow.com/questions/25582882/javascript-math-random-normal-distribution-gaussian-bell-curve
// Standard Normal variate using Box-Muller transform.
function randn_bm(n_inputs, n_neurons) {
    var u = n_inputs;
    var v = n_neurons;
    return math.sqrt( -2.0 * math.log( u ) ) * math.cos( 2.0 * math.PI * v );
}

class Layer_Dense {
  constructor (n_inputs, n_neurons){
    this.weights = 0.1 * randn_bm(n_inputs, n_neurons);
    this.biases = math.zeros(1, n_neurons);
  }

  forward (inputs) {
    var biasesmat = this.biases;
		// Since only adding matrices elementwise is supported, you need to make the biases into a matrix and not a vector.
		for (var i=0; i<inputs.size()[0]-1;i++) {biasesmat=math.concat(biasesmat, this.biases, 0);}
		this.output = math.add(math.multiply(inputs, this.weights), biasesmat);
  }
}

class Activation_ReLU {
  forward (inputs) {
    this.output = math.max(0, inputs);
  }
}

class Activation_Softmax {
  forward (inputs) {
    let exp_values = math.exp(inputs - math.max(inputs, axis=1, keepdims=True));
    let probabilities = exp_values / math.sum(exp_values, axis=1, keepdims=True);
    this.output = probabilities;
  }
}

var dense1 = new Layer_Dense(2, 3);
var activation1 = new Activation_ReLU();

var dense2 = new Layer_Dense(3, 3);
var activation2 = new Activation_Softmax();


dense1.forward(X);
activation1.forward(dense1.output);

dense2.forward(activation1.output);
activation2.forward(dense2.output);

console.log(activation2.output);
