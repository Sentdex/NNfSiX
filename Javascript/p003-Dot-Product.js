const inputs  = [1, 2, 3, 2.5];

const weights = [
    [ 0.2,   0.8,  -0.5,   1   ],
    [ 0.5,  -0.91,  0.26, -0.5 ],
    [-0.26, -0.27,  0.17,  0.87]
];

const biases  = [2, 3, 0.5];

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

// assumes a is 2D, b is 1D and all nested-arrays in a are same length as b which suffices for this use case
function dot(a, b) {
    const res = [];
    for (let i = 0; i < a.length; i++) {
        let dot = 0;
        for (let j = 0; j < b.length; j++) {
            dot += a[i][j] * b[j];
        }
        res.push(dot);
    }
    return res;
}

// assumes you are adding b on to a, where b can be a number or an array
function add(a, b) {
    if (Array.isArray(a) && typeof b === "number") {
        const res = [];
        for (let i = 0; i < a.length; i++) {
            res.append(a[i] + b);
        }
        return res;
    }
    const res = [];
    for (let i = 0; i < a.length; i++) {
        res.push(a[i] + b[i]);
    }
    return res;
}

const output = add(dot(weights, inputs), biases);
console.log(output);
