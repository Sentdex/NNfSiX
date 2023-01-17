// get the shape of a nested-array (assuming it is 'rectangular', but in many more or fewer dimensions)
function shape(a) {
	const res = [];
	let temp = a;
	while (Array.isArray(temp)) {
		res.push(temp.length);
		temp = temp[0];
	}
	return res;
}

// functions roughly as np.dot(a, b); (it works fine for this context)
function dot(a, b) {
	const res = [];
	const shapeA = shape(a);
	const shapeB = shape(b);
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

// divides elements in an array by elements in another array
function divide(a, b) {
	const res = [];
	const shapeA = shape(a);
	const shapeB = shape(b);
	if (typeof b === "number") {
		for (let i = 0; i < a.length; i++) {
				if (Array.isArray(a[i])) {
					res.push(divide(a[i], b));
				} else {
					res.push(a[i]/b);
				}
			}
	} else if (shapeB.length === shapeA.length - 1) {
		for (let i = 0; i < a.length; i++) {
			if (Array.isArray(a[i])) {
				res.push(divide(a[i], b[i]));
			} else {
				res.push(a[i]/b[i]);
			}
		}
	} else {
		for (let i = 0; i < a.length; i++) {
			if (Array.isArray(a[i])) {
				res.push(divide(a[i], b[i]));
			} else {
				res.push(a[i]/b[i]);
			}
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

// add but with the `-` operator instead (could also have made this `add(a + -b)`)
function subtract(a, b) {
	const res = [];
	if (Array.isArray(a) && typeof b === "number") {
		for (let i = 0; i < a.length; i++) {
			res.append(a[i] - b);
		}
		return res;
	} else if (Array.isArray(a) && Array.isArray(b)) {
		const shapeA = shape(a);
		const shapeB = shape(b);
		if (shapeA.length === 1 && shapeB.length === 1) {
			for (let i = 0; i < a.length; i++) {
				res.push(a[i] - b[i]);
			}
		} else if (shapeA.length === 2 && shapeB.length === 1 &&
			shapeA[0] === shapeB[0]) {
			for (let i = 0; i < shapeA[0]; i++) {
				const row = [];
				for (let j = 0; j < shapeA[1]; j++) {
					row.push(a[i][j] - b[i]);
				}
				res.push(row);
			}
		}
	}
	return res;
}

// functions roughly as np.exp(a);
function exp(a) {
	const res = [];
	for (let i = 0; i < a.length; i++) {
		if (Array.isArray(a[i])) {
			res.push(exp(a[i]));
		} else {
			res.push(Math.exp(a[i]));
		}
	}
	return res;
}

// functions roughly as np.max(a);
function max(a, axis = 0, keepdims = false) {
	const _shape = shape(a);
	if (_shape.length === 1 || axis === 0) {
		const res = Math.max(...a.flat(Infinity));
		return keepdims ? [res] : res;
	} else if (_shape.length === 2) {
		const res = [];
		if (axis === 1) {
			for (let i = 0; i < _shape[0]; i++) {
				const row = Math.max(...a[i]);
				res.push(keepdims ? [row] : row);
			}
		} else if (axis === 2) {
			for (let i = 0; i < _shape[0]; i++) {
				let max = a[0][i];
				for (let j = 1; j < _shape[1]; j++) {
					if (a[j][i] > max) {
						max = a[j][i];
					}
				}
				res.push(keepdims ? [max] : max);
			}
		}
		return res;
	}
}

// functions roughly as np.sum(a);
function sum(a, axis = 0, keepdims = false) {
	const _shape = shape(a);
	if (_shape.length === 1) {
		let res = 0;
		for (let i = 0; i < _shape[0]; i++) {
			res += a[i];
		}
		return keepdims ? [res] : res;
	} else if (_shape.length === 2) {
		const res = [];
		if (axis === 1) {
			for (let i = 0; i < _shape[0]; i++) {
				let row = 0;
				for (let j = 0; j < _shape[1]; j++) {
					row += a[i][j];
				}
				res.push(keepdims ? [row] : row);
			}
		} else if (axis === 2) {
			for (let i = 0; i < _shape[0]; i++) {
				let row = 0;
				for (let j = 0; j < _shape[1]; j++) {
					row += a[j][i];
				}
				res.push(keepdims ? [row] : row);
			}
		}
		return res;
	}
}

// replaces np.array().T
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

// replaces np.zeros()
function zeros(...dimensions) {
	const res = [];
	if (dimensions.length === 1) {
		while (dimensions[0]--) {
			res.push(0);
		}
	} else {
		while (dimensions[0]--) {
			res.push(zeros(...dimensions.slice(1)));
		}
	}
	return res;
}

class Layer_Dense {
	constructor(n_inputs, n_neurons) {
		this.weights = [];
		for (let i = 0; i < n_inputs; i++) {
			const temp = [];
			for (let j = 0; j < n_neurons; j++) {
				temp.push(2*Math.random() - 1);
			}
			this.weights.push(temp);
		}
		this.biases = zeros(n_neurons);
		this.output = null;
	}
	forward(inputs) {
		this.output = add(dot(inputs, this.weights), this.biases);
		return this;
	}
}

class Activation_ReLU {
	constructor() {
		this.output = null;
	}
	forward(inputs) {
		this.output = [];
		for (let i = 0; i < inputs.length; i++) {
			if (Array.isArray(inputs[i])) {
				this.output.push((new Activation_ReLU()).forward(inputs[i]).output);
			} else {
				this.output.push(Math.max(0, inputs[i]));
			}
		}
		return this;
	}
}

class Activation_Softmax {
	constructor() {
		this.output = null;
	}
	forward(inputs) {
		const exp_values = exp(subtract(inputs, max(inputs, 1)));
		const probabilities = divide(exp_values, sum(exp_values, 1));
		this.output = probabilities;
		return this;
	}
}

// Based on the code written by @vancegillies & updated by @daniel-kukiela
function spiral_data(points, classes) {
	const X = zeros(points*classes, 2);
	const y = Uint8Array.from(zeros(points*classes));
	const r_increment = 1/(points - 1);
	const t_increment = 4/(points - 1);
	for (let class_number = 0, i = 0; class_number < classes; class_number++) {
		let r = 0, t = class_number*4;
		while (r <= 1 && t <= 4*(class_number + 1)) {
			const random_t = t * Math.random()*points * 0.2;
			X[i][0] = r * Math.sin(random_t*2.5);
			X[i][1] = r * Math.cos(random_t*2.5);
			y[i] = class_number;
			r += r_increment;
			t += t_increment;
			i++;
		}
	}
	return [X, y];
}

/*
const layer_outputs = [
	[4.8,  1.21,  2.385],
	[8.9, -1.81,  0.2  ],
	[1.4,  1.051, 0.026]
];
*/

/*
const E = Math.E;
const exp_values = [];

for (let i = 0; i < layer_outputs.length; i++) {
	exp_values.push(Math.pow(E, layer_outputs[i]));
}
*/

/*
const exp_values = exp(layer_outputs);
*/

/*
console.log(exp_values);
*/

/*
const norm_base = sum(exp_values);
console.log(norm_base);
*/

/*
const norm_values = [];
for (let i = 0; i < exp_values.length; i++) {
	norm_values.push(exp_values[i]/norm_base);
}
*/

/*
const norm_values = divide(exp_values, sum(exp_values, 1));
*/

/*
console.log(norm_values);
*/

const [ X, y ] = spiral_data(100, 3);

const dense1 = new Layer_Dense(2, 3);
const activation1 = new Activation_ReLU();

const dense2 = new Layer_Dense(3, 3);
const activation2 = new Activation_Softmax();

dense1.forward(X);
activation1.forward(dense1.output);

dense2.forward(activation1.output);
activation2.forward(dense2.output);

console.log(activation2.output.slice(0, 5));
