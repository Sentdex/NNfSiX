/*
Creates a dense layer of neurons with a ReLU activation function, and feeds forward inputs through them.
Associated YT tutorial: https://www.youtu.be/gmjzbpSVY1A
*/

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

// Based on the code written by @vancegillies & updated by @daniel-kukiela
function spiral_data(points, classes) {
	const X = zeros(points * classes, 2);
	const y = Uint8Array.from(zeros(points*classes));
	const r_increment = 1 / (points - 1);
	const t_increment = 4 / (points - 1);
	for (let class_number = 0, i = 0; class_number < classes; class_number++) {
		let r = 0;
		let t = class_number * 4
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
const inputs = [0, 2, -1, 3.3, -2.7, 1.1, 2.2, -100];
const outputs = [];

for (let i = 0; i < inputs.length; i++) {
	//if (i > 0) {
		//outputs.push(inputs[i]);
	//} else {
		//outputs.push(0);
	//}
	outputs.push(Math.max(0, inputs[i]));
}

console.log(outputs);
*/

const [ X, y ] = spiral_data(100, 3);

const layer1 = new Layer_Dense(2, 5);
const activation1 = new Activation_ReLU();

layer1.forward(X);
//console.log(layer1.output);
activation1.forward(layer1.output);
console.log(activation1.output);
