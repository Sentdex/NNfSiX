#[macro_use]

extern crate ndarray;
extern crate nalgebra;
use ndarray::prelude::*;
use ndarray::Array;
use ndarray_rand::*;
use ndarray_rand::rand_distr::*;
use nalgebra::*;
use std::num;
use std::f64;
use std::convert::From;

struct Layer_Dense {
	weights: Array2<f64>,
	biases: Array2<f64>,
	output: Option<Array2<f64>>,
}
impl Layer_Dense {
 	fn init(n_inputs: usize, n_neurons: usize) -> Self {
 		let weights =  Array2::random((n_inputs, n_neurons ), Uniform::new(-1.0, 1.0));
 		let biases = Array2::zeros((1, n_neurons));
		Layer_Dense{
			weights,
			biases,
			output: None,
		}
	}
	fn forward(&mut self, inputs: Array2<f64>){
		self.output = Some(inputs.dot(&self.weights) + &self.biases);
	}
}

// CREDIT FOR THE DATABASE CODE GOES TO https://github.com/SLASHLogin

type X = Array<f64, ndarray::Dim<[usize; 2]>>;
type Y = Array<f64, ndarray::Dim<[usize; 1]>>;

fn create_data(points: usize, classes: usize) -> (Array<f64, ndarray::Dim<[usize; 2]>>, Array<f64, ndarray::Dim<[usize; 1]>>){
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



#[derive(Debug)]
struct Activation_ReLU {
	output: Vec<f64>
}

impl Activation_ReLU {
	fn init() -> Self {
		let output = vec![0., 0., 0., 0., 0.];
		Activation_ReLU{
			output
		}
	}


	fn ActivationReLU(&mut self, inputs: Array2<f64>){
		self.output = inputs.iter().map(|x| x.max(0.0)).collect::<Vec<f64>>();
	}	
}

fn main() {
    let (x, y) = create_data(100, 3);

    let mut l1 = Layer_Dense::init(2, 5);
    l1.forward(x);
    println!("{:?}", l1.output);
    let mut activated = Activation_ReLU::init();
    activated.ActivationReLU(l1.output.unwrap());
    println!("{:?}", activated.output);
    let hello = Array::from_shape_vec((300, 5), activated.output);
    println!("{:?}", hello);
    
}
