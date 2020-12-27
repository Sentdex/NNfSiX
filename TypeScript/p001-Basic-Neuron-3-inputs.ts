const inputs: Array<number> = [1.2, 5.1, 2.1];
const weights: Array<number> = [3.1, 2.1, 8.7];
const bias: number = 3.0;

const output = inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias
console.log(output);
