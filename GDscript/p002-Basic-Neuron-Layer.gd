"""
Creates a simple layer of neurons, with 4 inputs.
"""

var inputs = [1.0, 2.0, 3.0, 2.5]

var weights1 = [0.2, 0.8, -0.5, 1.0]
var weights2 = [0.5, -0.91, 0.26, -0.5]
var weights3 = [-0.26, -0.27, 0.17, 0.87]

var bias1 = 2.0
var bias2 = 3.0
var bias3 = 0.5


func output():
	var output = [inputs[0]*weights1[0] + inputs[1]*weights1[1] + inputs[2]*weights1[2] + inputs[3]*weights1[3] + bias1,
		  inputs[0]*weights2[0] + inputs[1]*weights2[1] + inputs[2]*weights2[2] + inputs[3]*weights2[3] + bias2,
		  inputs[0]*weights3[0] + inputs[1]*weights3[1] + inputs[2]*weights3[2] + inputs[3]*weights3[3] + bias3]
	print(output)
