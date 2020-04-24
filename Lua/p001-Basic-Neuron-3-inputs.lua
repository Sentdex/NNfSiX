--[[
Creates a basic neuron with 3 inputs.
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
]]--

Inputs = {1.2, 5.1, 2.1}
Weights = {3.1, 2.1, 8.7}
Bias = 3.0

Output = Inputs[1]*Weights[1] + Inputs[2]*Weights[2] + Inputs[3]*Weights[3] + Bias
print(Output)