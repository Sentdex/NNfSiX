const inputs: Array<number> = [1.0, 2.0, 3.0, 2.5];

const weights: Array<Array<number>> = [[0.2, 0.8, -0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.8]];

const biases: Array<number> = [2.0, 3.0, 0.5]

function dotProduct(weights: number[][], inputs: number[]) {
    let outputs: Array<number> = [];
    for (let i = 0; i < weights.length; i++) { 
        let output: number = 0;
        for (let j = 0; j < inputs.length; j++) { 
            output += weights[i][j] * inputs[j];
        }
        outputs[i] = output;
    }
    return outputs;
}

function addMatrix(vector1: number[], vector2: number[]) {
    let output: Array<number> = [];

    for (let i = 0; i < vector1.length; i++) { 
        output[i] = vector1[i] + vector2[i];
    }

    return output;
}


const outputs: Array<number> = addMatrix(dotProduct(weights, inputs), biases);
console.log(outputs);
