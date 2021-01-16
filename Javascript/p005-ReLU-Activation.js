/*
Creates a dense layer of neurons with a ReLU activation function, and feeds forward inputs through them.
Associated YT tutorial: https://www.youtu.be/gmjzbpSVY1A
*/

const math = require("mathjs");

// There is no nnfs library for JS, so I am just using the previous data.
const X = math.matrix([
	[1.0, 2.0, 3.0, 2.5],
	[2.0, 5.0, -1.0, 2.0],
	[-1.5, 2.7, 3.3, -0.8]]);

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
		this.output = math.matrix(inputs._data.map(layer => layer.map(i => i<0?0:i)));
	}
}

var layer1 = new Layer_Dense(4, 5);
var activation1 = new Activation_ReLU();

layer1.forward(X);
//console.log(layer1.output);
activation1.forward(layer1.output);
console.log(activation1.output);