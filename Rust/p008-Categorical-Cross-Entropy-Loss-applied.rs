use ndarray::{Array, Array1, Array2, Axis, Dimension, Ix1, Ix2};
use ndarray_rand::RandomExt;
use rand_distr::Normal;

fn main() {
    let (x, y) = spiral_data(100, 3);

    let mut dense1 = LayerDense::new(2, 3);
    let mut dense2 = LayerDense::new(3, 3);

    dense1.forward(x);
    let activation1 = activation_relu(dense1.outputs.unwrap());

    dense2.forward(activation1);
    let activation2 = softmax(dense2.outputs.unwrap());

    println!("{:?}", activation2);

    let loss = CategoricalCrossentropy::calculate(activation2, y).unwrap();

    println!("Loss: {}", loss);
}

#[derive(Debug)]
struct LayerDense {
    weights: Array2<f64>,
    biases: Array2<f64>,
    outputs: Option<Array2<f64>>,
}

impl LayerDense {
    fn new(n_inputs: usize, n_neurons: usize) -> Self {
        let weights = Array::random((n_inputs, n_neurons), Normal::new(0.0, 1.0).unwrap());
        let biases = Array::zeros((1, n_neurons));
        LayerDense {
            weights,
            biases,
            outputs: None,
        }
    }

    fn forward(&mut self, inputs: Array2<f64>) {
        self.outputs = Some(inputs.dot(&self.weights) + &self.biases);
    }
}

fn activation_relu(input: Array2<f64>) -> Array2<f64> {
    input.map(|x| x.max(0.0))
}

fn softmax(input: Array2<f64>) -> Array2<f64> {
    let mut output = Array2::zeros(input.raw_dim());
    for (in_row, mut out_row) in input.axis_iter(Axis(0)).zip(output.axis_iter_mut(Axis(0))) {
        let mut max = 0.0;
        for col in in_row.iter() {
            if col > &max {
                max = *col;
            }
        }
        let exp = in_row.map(|x| (x - max).exp());
        let sum = exp.sum();
        out_row.assign(&(exp / sum));
    }
    output
}

trait Loss<T: Dimension> {
    fn forward(output: Array2<f64>, y: Array<f64, T>) -> Array1<f64>;

    fn calculate(output: Array2<f64>, y: Array<f64, T>) -> Option<f64> {
        let sample_losses = Self::forward(output, y);
        sample_losses.mean()
    }
}

struct CategoricalCrossentropy {}

impl Loss<Ix1> for CategoricalCrossentropy {
    fn forward(output: Array2<f64>, y: Array<f64, Ix1>) -> Array1<f64> {
        y.iter()
            .zip(output.outer_iter())
            .map(|(&targ_idx, distribution)| {
                -distribution[targ_idx as usize].clamp(1e-7, 1.0 - 1e-7).ln()
            })
            .collect()
    }
}

impl Loss<Ix2> for CategoricalCrossentropy {
    fn forward(output: Array2<f64>, y: Array<f64, Ix2>) -> Array1<f64> {
        let sum = (y * output).sum_axis(Axis(1));

        sum.iter()
            .map(|&confidence| -confidence.clamp(1e-7, 1.0 - 1e-7).ln())
            .collect()
    }
}

type X = Array2<f64>;
type Y = Array1<f64>;

pub fn spiral_data(points: usize, classes: usize) -> (X, Y) {
    let mut y: Array1<f64> = Array::zeros(points * classes);
    let mut x = Vec::with_capacity(points * classes * 2);

    for class_number in 0..classes {
        let r = Array::linspace(0.0, 1.0, points);
        let t = (Array::linspace(
            (class_number * 4) as f64,
            ((class_number + 1) * 4) as f64,
            points,
        ) + Array::random(points, Normal::new(0.0, 1.0).unwrap()) * 0.2)
            * 2.5;
        let r2 = r.clone();
        let mut c = Vec::new();
        for (x, y) in (r * t.map(|x| (x).sin()))
            .into_raw_vec()
            .iter()
            .zip((r2 * t.map(|x| (x).cos())).into_raw_vec().iter())
        {
            c.push(*x);
            c.push(*y);
        }
        for (ix, n) in
            ((points * class_number)..(points * (class_number + 1))).zip((0..).step_by(2))
        {
            x.push(c[n]);
            x.push(c[n + 1]);
            y[ix] = class_number as f64;
        }
    }
    (
        ndarray::ArrayBase::from_shape_vec((points * classes, 2), x).unwrap(),
        y,
    )
}

