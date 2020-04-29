inputs = [1.2_f64, 5.1_f64, 2.1_f64]
weights = [3.1_f64, 2.1_f64, 8.7_f64]
bias = 3.0_f64

output : Float64 = inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias
puts output
