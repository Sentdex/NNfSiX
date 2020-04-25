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
