--[[
Creates a simple layer of neurons, with 4 inputs.
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=lGLto9Xd7bU
]]--

Inputs = {1.0, 2.0, 3.0, 2.5}

Weights1 = {0.2, 0.8, -0.5, 1.0}
Weights2 = {0.5, -0.91, 0.26, -0.5}
Weights3 = {-0.26, -0.27, 0.17, 0.87}

Bias1 = 2.0
Bias2 = 3.0
Bias3 = 0.5

Output = {Inputs[1]*Weights1[1] + Inputs[2]*Weights1[2] + Inputs[3]*Weights1[3] + Inputs[4]*Weights1[4] + Bias1,
          Inputs[1]*Weights2[1] + Inputs[2]*Weights2[2] + Inputs[3]*Weights2[3] + Inputs[4]*Weights2[4] + Bias2,
          Inputs[1]*Weights3[1] + Inputs[2]*Weights3[2] + Inputs[3]*Weights3[3] + Inputs[4]*Weights3[4] + Bias3}

print(string.format("[%f,%f,%f]\n",Output[1], Output[2], Output[3]))