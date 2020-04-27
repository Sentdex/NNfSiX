// Doing dot product with a layer of neurons and multiple inputs
// Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4

fn main() {
    let inputs = vec![1.0, 2.0, 3.0, 2.5];
    let mut weights = vec![];
    weights.push(vec![0.2, 0.8, -0.5, 1.0]);
    weights.push(vec![0.5, -0.91, 0.26, -0.5]);
    weights.push(vec![-0.26, -0.27, 0.17, 0.87]);
    
    let biases = vec![2.0, 3.0, 0.5];

    let result = add(&dot_product(&weights, &inputs), &biases);
    
    println!("{:?}", result);
}

fn dot_product(weights: &[Vec<f64>], inputs: &Vec<f64>) -> Vec<f64> {
        let mut output = vec![];
        for w in weights.iter() {
            let mut product = vec![];
            for index in 0..inputs.len() {
                product.push(w[index] * inputs[index]);
            }
            let sum = product.iter().sum();
        output.push(sum);
        }
        output
}

fn add(vector: &Vec<f64>, biases: &Vec<f64>) -> Vec<f64> {
    let mut vals = vec![];
    for (v, b) in vector.iter().zip(biases) {
        vals.push(v + b);
    }
    vals
    
}
