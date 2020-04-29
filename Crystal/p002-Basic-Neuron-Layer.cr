inputs = [1.0_f64, 2.0_f64, 3.0_f64, 2.5_f64]

weights1 = [0.2_f64, 0.8_f64, -0.5_f64, 1.0_f64]
weights2 = [0.5_f64, -0.91_f64, 0.26_f64, -0.5_f64]
weights3 = [-0.26_f64, -0.27_f64, 0.17_f64, 0.87_f64]

bias1 = 2.0_f64
bias2 = 3.0_f64
bias3 = 0.5_f64

output = [inputs[0]*weights1[0] + inputs[1]*weights1[1] + inputs[2]*weights1[2] + bias1,
          inputs[0]*weights2[0] + inputs[1]*weights2[1] + inputs[2]*weights2[2] + bias2,
          inputs[0]*weights3[0] + inputs[1]*weights3[1] + inputs[2]*weights3[2] + bias3]

puts output
