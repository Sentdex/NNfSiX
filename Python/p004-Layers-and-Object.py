'''
Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
'''

import numpy as np 

np.random.seed(0)

X = [[1, 2, 3, 2.5],
     [2.0, 5.0, -1.0, 2.0],
     [-1.5, 2.7, 3.3, -0.8]]


class Layer_Dense:
    def __init__(self, n_inputs, n_neurons):
        self.weights = 0.10 * np.random.randn(n_inputs, n_neurons)
        self.biases = np.zeros((1, n_neurons))
    def forward(self, inputs):
        self.output = np.dot(inputs, self.weights) + self.biases

layer1 = Layer_Dense(np.array(X).shape[1], 5)
layer1.forward(X)
#print(layer1.output) 

layer2 = Layer_Dense(np.array(layer1.output).shape[1], 2)
layer2.forward(layer1.output)
print(layer2.output)
