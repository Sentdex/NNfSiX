
// Creates a basic neuron with 3 inputs.

// Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI

fn main() {
    let inputs = vec![1.0, 2.0, 3.0];
    let weights = vec![3.1, 2.1, 8.7];
    let bias = 3.0;
    let output = inputs[0] * weights[0] +
                 inputs[1] * weights[1] +
                 inputs[2] * weights[2] +
                 bias;
    println!("{}", output);
}