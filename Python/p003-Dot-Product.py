'''
Doing dot product with a layer of neurons and multiple inputs
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
'''

import numpy as np 

inputs = [1.0, 2.0, 3.0, 2.5]
weights = [[0.2, 0.8, -0.5, 1.0],
           [0.5, -0.91, 0.26, -0.5],
           [-0.26, -0.27, 0.17, 0.87]]

biases = [2.0, 3.0, 0.5]

output = np.dot(weights, inputs) + biases
print(output)

# calculation using standart Python list
layer_outputs: list = [(sum([(w * inputs[i]) for i, w in enumerate(weight)]) + biases[index]) for index, weight in enumerate(weights)]
print(layer_outputs)

# calculation using NumPy Array
output_np = [sum(weight * np.array(inputs)) for weight in np.array(weights)] + np.array(biases)
print(output_np)

# calculation using Dot Product
output = np.dot(weights, inputs) + biases
print(output)
