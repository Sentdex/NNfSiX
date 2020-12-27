const inputs: Array<number> = [1.0, 2.0, 3.0, 2.5];

const weights1: Array<number> = [0.2, 0.8, -0.5, 1.0];
const weights2: Array<number> = [0.5, -0.91, 0.26, -0.5];
const weights3: Array<number> = [-0.26, -0.27, 0.17, 0.8];

const bias1: number = 2.0;
const bias2: number = 3.0;
const bias3: number = 0.5;

const output: Array<number> = [inputs[0]*weights1[0] + inputs[1]*weights1[1] + inputs[2]*weights1[2] + inputs[3]*weights1[3] + bias1,
          inputs[0]*weights2[0] + inputs[1]*weights2[1] + inputs[2]*weights2[2] + inputs[3]*weights2[3] + bias2,
          inputs[0]*weights3[0] + inputs[1]*weights3[1] + inputs[2]*weights3[2] + inputs[3]*weights3[3] + bias3]

console.log(output);
