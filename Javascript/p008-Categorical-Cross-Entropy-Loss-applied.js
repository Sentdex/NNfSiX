// check if an object is an array
function isArray(a) {
	return Array.isArray(a) || ArrayBuffer.isView(a);
}

// get the shape of a nested-array (assuming it is 'rectangular', but in many more or fewer dimensions)
function shape(a) {
	const res = [];
	let temp = a;
	while (isArray(temp)) {
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

// multiplies elements in an array by elements in another array
function multiply(a, b) {
	const res = [];
	if (typeof b === "number") {
		for (let i = 0; i < a.length; i++) {
			if (isArray(a[i])) {
				res.push(multiply(a[i], b));
			} else {
				res.push(a[i]*b);
			}
		}
	} else {
		for (let i = 0; i < a.length; i++) {
			if (isArray(a[i])) {
				res.push(multiply(a[i], b[i]));
			} else {
				res.push(a[i]*b[i]);
			}
		}
	}
	return res;
}

// divides elements in an array by elements in another array
function divide(a, b) {
	const res = [];
	if (typeof b === "number") {
		for (let i = 0; i < a.length; i++) {
			if (isArray(a[i])) {
				res.push(divide(a[i], b));
			} else {
				res.push(a[i]/b);
			}
		}
	} else {
		for (let i = 0; i < a.length; i++) {
			if (isArray(a[i])) {
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
	if (isArray(a) && typeof b === "number") {
		for (let i = 0; i < a.length; i++) {
			res.append(a[i] + b);
		}
		return res;
	} else if (isArray(a) && isArray(b)) {
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
	if (isArray(a) && typeof b === "number") {
		for (let i = 0; i < a.length; i++) {
			res.append(a[i] - b);
		}
		return res;
	} else if (isArray(a) && isArray(b)) {
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
		if (isArray(a[i])) {
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

// replaces np.clip(min, max)
function clip(a, min, max) {
	const res = [];
	for (let i = 0; i < a.length; i++) {
		if (isArray(a[i])) {
			res.push(clip(a[i]));
		} else {
			if (a[i] < min) {
				res.push(min);
			} else if (a[i] > max) {
				res.push(max);
			} else {
				res.push(a[i]);
			}
			// Alternative: res.push(Math.max(min, Math.min(a[i], max)));
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
			if (isArray(inputs[i])) {
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

class Loss {
	constructor() {
		this.output = null;
	}
	calculate(output, y) {
		// uses this.output for consistency with other classes
		const sample_losses = this.forward(output, y).output;
		let total = 0;
		for (let i = 0; i < sample_losses.length; i++) {
			total += sample_losses[i];
		}
		const data_loss = total / sample_losses.length;
		this.output = data_loss;
		return this;
	}
}

class Loss_CategoricalCrossentropy extends Loss {
	constructor() {
		super();
	}
	forward(y_pred, y_true) {
		// this value is never actually used...?
		//const samples = y_pred.length;
		const y_pred_clipped = clip(y_pred, 1e-7, 1 - 1e-7);
		
		let correct_confidences = [];
		const _shape = shape(y_true);
		if (_shape.length === 1) {
			for (let i = 0; i < _shape[0]; i++) {
				correct_confidences.push(y_pred_clipped[i][y_true[i]]);
			}
		} else if (_shape.length === 2) {
			correct_confidences = sum(multiply(y_pred_clipped, y_true), 1);
		}
		const negative_log_likelihoods = [];
		for (let i = 0; i < correct_confidences.length; i++) {
			negative_log_likelihoods.push(-Math.log(correct_confidences[i]));
		}
		this.output = negative_log_likelihoods;
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

const [ X, y ] = spiral_data(100, 3);

const dense1 = new Layer_Dense(2, 3);
const activation1 = new Activation_ReLU();

const dense2 = new Layer_Dense(3, 3);
const activation2 = new Activation_Softmax();

dense1.forward(X);
activation1.forward(dense1.output);

dense2.forward(activation1.output);
activation2.forward(dense2.output);

const loss_function = new Loss_CategoricalCrossentropy();
const loss = loss_function.calculate(activation2.output, y).output;
console.log("Loss:", loss);

/*
const softmax_outputs = [
	[0.7,  0.1, 0.2 ],
	[0.1,  0.5, 0.4 ],
	[0.02, 0.9, 0.08]
];
const class_targets   = [0, 1, 1];

const losses = [];
let total = 0;
for (let i = 0; i < softmax_outputs.length; i++) {
	// targ_idx     = class_targets[i]
	// distribution = softmax_outpus[i]
	const loss = -Math.log(softmax_outputs[i][class_targets[i]]);
	losses.push(loss);
	total += loss;
}

console.log(losses);
console.log(total / losses.length);
*/
