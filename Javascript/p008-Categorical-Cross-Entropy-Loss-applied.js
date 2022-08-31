/*
Creates a dense layer of neurons with a ReLU activation function, and feeds forward inputs through them.
Associated YT tutorial: https://www.youtu.be/gmjzbpSVY1A
*/

const math = require("mathjs");

const clamp = (num, min, max) => Math.min(Math.max(num, min), max)

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
      const random_t = t + math.random(points) * 0.2;

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

class Layer_Dense {
	constructor (n_inputs, n_neurons) {
		this.weights = math.random([n_inputs, n_neurons], -1.0, 1.0);
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
	constructor () {}
	
	forward (inputs) {
		this.output = math.matrix(inputs._data.map(batch => batch.map(i => i<0?0:i)));
	}
}

class Activation_Softmax {
    constructor () {}

    forward (inputs) {
        var exp_values = math.matrix(inputs._data.map(batch => batch.map(i => math.exp(i - math.max(batch)))));
        var probabilities = math.matrix(exp_values._data.map(batch => batch.map(i => i / math.sum(batch))));
        this.output = probabilities;
    }
}

class Loss {
  constructor() {}

  calculate(output, y) {
    var sample_losses = this.forward(output, y);
    var data_loss = math.mean(sample_losses);
    return data_loss;
  }
}

class Loss_CategoricalCrossentropy extends Loss {
  forward(y_pred, y_true) {
      // returns a math.matrix with the negative_log_likelihoods of the confidences
      var correct_confidences = [];
      var y_pred_clipped = math.matrix(y_pred._data.map(batch => batch.map(value => clamp(value, 1e-7, 1-1e-7))));

      if (y_true.size().length == 1) {
        // everything is in a single array
          y_pred_clipped._data.map((batch, index) => {
              const index2 = y_true._data[index];
              correct_confidences.push(batch[index2]);
          });
      }

      else {
      y_pred_clipped._data.map((batch, index) => batch.map((value, index2) => {
        if (y_true[index][index2])
              correct_confidences.push(value);
      }));}
    
      var negative_log_likelihoods = math.matrix(correct_confidences.map(value => {return -1 * Math.log(value)}))
      return negative_log_likelihoods;
  }
} 

let [X, y] = spiral_data(100, 3);

var dense1 = new Layer_Dense(2, 3);
var activation1 = new Activation_ReLU();

var dense2 = new Layer_Dense(3, 3);
var activation2 = new Activation_Softmax();

dense1.forward(X);
activation1.forward(dense1.output);

dense2.forward(activation1.output);
activation2.forward(dense2.output);

console.log(activation2.output._data.slice(0,5));

var loss_function = new Loss_CategoricalCrossentropy();
var loss = loss_function.calculate(activation2.output, y);

console.log("Loss: " + loss);

