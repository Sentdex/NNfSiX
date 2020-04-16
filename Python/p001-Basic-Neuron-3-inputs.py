'''
Creates a basic neuron with 3 inputs.

Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
'''

inputs = [1.2, 5.1, 2.1]
weights = [3.1, 2.1, 8.7]
bias = 3.0

output = inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias
print(output)
