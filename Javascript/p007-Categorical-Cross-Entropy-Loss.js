/*
const b = 5.2;

console.log(Math.log(b));
console.log(Math.E ** 1.6486586255873816);
*/

const softmax_output = [0.7, 0.1, 0.2];
const target_output = [1, 0, 0];

const loss = -(Math.log(softmax_output[0])*target_output[0] +
			   Math.log(softmax_output[1])*target_output[1] +
			   Math.log(softmax_output[2])*target_output[2]);

console.log(loss);
// loss simplified
console.log(-Math.log(softmax_output[0]));

console.log(-Math.log(0.7));
console.log(-Math.log(0.5));
