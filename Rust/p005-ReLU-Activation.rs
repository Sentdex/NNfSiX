use ndarray::Array;
use ndarray::Array2;
use ndarray_rand::RandomExt;
use rand_distr::Normal;

fn main() {
    let (x, _y) = spiral_data(100, 3);

    let mut layer1 = LayerDense::new(2, 5);

    layer1.forward(x);
    let result = layer1.outputs.unwrap().map(|x| activation_relu(*x));
    println!("{:?}", result);
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
        self.outputs = Some(inputs.dot(&self.weights) + &self.biases)
    }
}

fn activation_relu(input: f64) -> f64 {
    input.max(0.0)
}

type X = Array<f64, ndarray::Dim<[usize; 2]>>;
type Y = Array<f64, ndarray::Dim<[usize; 1]>>;

fn spiral_data(points: usize, classes: usize) -> (X, Y) {
    let mut y: ndarray::Array<f64, ndarray::Dim<[usize; 1]>> = Array::zeros(points * classes);
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
        let mut c = Vec::<f64>::new();
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
