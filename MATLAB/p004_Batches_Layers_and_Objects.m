% Associated YT NNFS tutorial: https://youtu.be/TEWy9vZcxW4
%   Part 004: Batches, Layers, and Objects
% 
%   NOTE: This script requires the class definition files to be in the same
%   directory (i.e. Layer_Dense.m). See that file for information on MATLAB
%   class usage

rng(0)

% Define input feature sets
X = [ 1,    2,    3,    2.5
      2.0,  5.0, -1.0,  2.0
     -1.5,  2.7,  3.3, -0.8];

% Initialize layers
layer1 = Layer_Dense(4, 5);
layer2 = Layer_Dense(5, 2);

% Perform forward pass through the neural network
layer1 = forward(layer1, X);
%disp(layer1.output)
layer2 = forward(layer2, layer1.output);
disp(layer2.output)
