"""
Creates a basic neuron with 3 inputs.
"""

var inputs = [1, 2, 3]
var weights = [0.2, 0.8, -0.5]
var bias = 2


func output():
	var output = inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias
	print(output)
