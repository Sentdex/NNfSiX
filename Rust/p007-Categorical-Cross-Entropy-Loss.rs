fn main() {
    let softmax_output: [f64; 3] = [0.7, 0.1, 0.2];

    let target_output: [f64; 3] = [1., 0., 0.];

    let loss = -(softmax_output[0].ln() * target_output[0]
        + softmax_output[1].ln() * target_output[1]
        + softmax_output[2].ln() * target_output[2]);

    println!("{}", loss);

    println!("{}", -0.7_f64.ln());
    println!("{}", -0.5_f64.ln());
}
