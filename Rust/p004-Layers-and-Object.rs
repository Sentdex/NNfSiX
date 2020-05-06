//Associated YT tutorial: https://youtu.be/TEWy9vZcxW4

use ndarray::arr2;
use ndarray::Array;
use ndarray::Array2;
use ndarray_rand::rand_distr::Uniform;
use ndarray_rand::RandomExt;

fn main() {
    let x = arr2(&[
        [1., 2.0, 3.0, 2.5],
        [2.0, 5.0, -1.0, 2.0],
        [-1.5, 2.7, 3.3, -0.8],
    ]);

    let mut layer1 = LayerDense::new(4, 5);
    let mut layer2 = LayerDense::new(5, 2);

    layer1.forward(x);
    layer2.forward(layer1.outputs.unwrap());
    println!("{:?}", layer2);
}

#[derive(Debug)]
struct LayerDense {
    weights: Array2<f64>,
    biases: Array2<f64>,
    outputs: Option<Array2<f64>>,
}

impl LayerDense {
    fn new(n_inputs: usize, n_neurons: usize) -> Self {
        let weights = Array::random((n_inputs, n_neurons), Uniform::new(-1., 1.));
        let biases = Array::zeros((1, n_neurons));
        LayerDense {
            weights,
            biases,
            outputs: None,
        }
    }
    fn forward(&mut self, inputs: Array2<f64>) {
        self.outputs = Some(inputs.dot(&self.weights) + &self.biases)
    }
}
