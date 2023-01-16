const inputs   = [
	[ 1,   2,    3,    2.5],
	[ 2,   5,   -1,    2  ],
	[-1.5, 2.7,  3.3, -0.8]
];

const weights  = [
	[ 0.2,   0.8,  -0.5,   1   ],
	[ 0.5,  -0.91,  0.26, -0.5 ],
	[-0.26, -0.27,  0.17,  0.87]
];

const biases   = [2, 3, 0.5];

const weights2 = [
	[ 0.1,  -0.14,  0.5 ],
	[-0.5,   0.12, -0.33],
	[-0.44,  0.73, -0.13]
];

const biases2  = [-1, 2, -0.5];

/*
const layer_outputs = []; // Output of current layer
for (let i = 0; i < weights.length; i++) {
	// weights[i] = neuron_weights
	// biases[i]  = neuron_bias
	let neuron_output = 0; // Output of given neuron
	for (let j = 0; j < inputs.length; j++) {
		// inputs[j]     = n_input
		// weights[i][j] = weight
		neuron_output += inputs[j]*weights[i][j];
	}
	neuron_output += biases[i];
	layer_outputs.push(neuron_output);
}

console.log(layer_outputs);
*/

// get the shape of a nested-array (assuming it is 'rectangular', but in many more or fewer dimensions)
function shape(a) {
	const res = [];
	let temp  = a;
	while (Array.isArray(temp)) {
		res.push(temp.length);
		temp = temp[0];
	}
	return res;
}

// functions roughly as np.dot(a, b); (it works fine for this context)
function dot(a, b) {
	const res  = [];
	let shapeA = shape(a);
	let shapeB = shape(b);
	if (shapeA.length === 1 && shapeB.length === 1) {
		let res = 0;
		for (let i = 0; i < shapeA[0]; i++) {
			res += a[i]*b[i];
		}
		return res;
	} else if (shapeA.length === 2 && shapeB.length === 1) {
		for (let i = 0; i < a.length; i++) {
			let dot = 0;
			for (let j = 0; j < b.length; j++) {
				dot += a[i][j]*b[j];
			}
			res.push(dot);
		}
	} else if (shapeA.length === 2 && shapeB.length === 2 && shapeA[1] === shapeB[0]) {
		for (let i = 0; i < shapeA[0]; i++) {
			const _dots = [];
			for (let j = 0; j < shapeB[1]; j++) {
				let _dot = 0;
				for (let k = 0; k < shapeB[0]; k++) {
					_dot += a[i][k]*b[k][j];
				}
				_dots.push(_dot);
			}
			res.push(_dots);
		}
	}
	return res;
}

// assumes you are adding b on to a, where b can be a number or an array
function add(a, b) {
	const res = [];
	if (Array.isArray(a) && typeof b === "number") {
		for (let i = 0; i < a.length; i++) {
			res.append(a[i] + b);
		}
		return res;
	} else if (Array.isArray(a) && Array.isArray(b)) {
		const shapeA = shape(a);
		const shapeB = shape(b);
		if (shapeA.length === 1 && shapeB.length === 1) {
			for (let i = 0; i < a.length; i++) {
				res.push(a[i] + b[i]);
			}
		} else if (shapeA.length === 2 && shapeB.length === 1 &&
			shapeA[1] === shapeB[0]) {
			for (let i = 0; i < shapeA[0]; i++) {
				const row = [];
				for (let j = 0; j < shapeA[1]; j++) {
					row.push(a[i][j] + b[j]);
				}
				res.push(row);
			}
		}
	}
	return res;
}

/*
console.log(dot([
	[ 0.49, 0.97, 0.53, 0.05],
	[ 0.33, 0.65, 0.62, 0.51],
	[ 1,    0.38, 0.61, 0.45],
	[ 0.74, 0.27, 0.64, 0.17],
	[ 0.36, 0.17, 0.96, 0.12]
], [
	[0.79, 0.32, 0.68, 0.9,  0.77],
	[0.18, 0.39, 0.12, 0.93, 0.09],
	[0.87, 0.42, 0.6,  0.71, 0.12],
	[0.45, 0.55, 0.4,  0.78, 0.81]
]));
*/

function transpose(a) {
	const res = [];
	const _shape = shape(a);
	if (_shape.length === 2) {
		for (let i = 0; i < _shape[1]; i++) {
			const row = [];
			for (let j = 0; j < _shape[0]; j++) {
				row.push(a[j][i]);
			}
			res.push(row);
		}
	}
	return res;
}

/*
console.log(transpose([
	[0.49, 0.97, 0.53, 0.05, 0.33],
	[0.65, 0.62, 0.51, 1,    0.38],
	[0.61, 0.45, 0.74, 0.27, 0.64],
	[0.17, 0.36, 0.17, 0.96, 0.12],
	[0.79, 0.32, 0.68, 0.9,  0.77]
]));
*/

/*
const layer1_outputs = add(dot(inputs, transpose(weights)), biases);
const layer2_outputs = add(dot(layer1_outputs, transpose(weights2)), biases2);
console.log(layer2_outputs);
*/

const X = [
	[ 1,   2,    3,    2.5],
	[ 2,   5,   -1,    2  ],
	[-1.5, 2.7,  3.3, -0.8]
];

class Layer_Dense {
	constructor(n_inputs, n_neurons) {
		this.weights = [];
		for (let i = 0; i < n_inputs; i++) {
			const temp = [];
			for (let j = 0; j < n_neurons; j++) {
				temp.push(Math.random()*2 - 1);
			}
			this.weights.push(temp);
		}
		this.biases = [];
		for (let i = 0; i < n_neurons; i++) {
			this.biases.push(0);
		}
	}
	forward(inputs) {
		this.output = add(dot(inputs, this.weights), this.biases);
	}
}

const layer1 = new Layer_Dense(4, 5);
const layer2 = new Layer_Dense(5, 2);

layer1.forward(X);
// console.log(layer1.output);
layer2.forward(layer1.output);
console.log(layer2.output);
