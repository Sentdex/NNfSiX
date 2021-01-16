% Associated YT NNFS tutorial: https://youtu.be/TEWy9vZcxW4
%   Part 004: Batches, Layers, and Objects
% 
% 
% Usage of the 'Layer_Dense' struct
% 
% % Constructor Function:  Requires: number of input features to the layer,
% %                                  number of neurons in the layer
% %                        Modifies: N/A 
% %                        Returns : the Layer_Dense object with intial 
% %                                  weights and biases
% %                                    
% % 
% % 'forward' Method:  Requires: inputs to the layer
% %                    Modifies: N/A
% %                    Returns : a copy of the parent struct with an
% %                              updated 'output' property





% Set the random number generator seed for reproducibility
rng(0)

% Define input feature sets
X = [ 1,    2,    3,    2.5
      2.0,  5.0, -1.0,  2.0
     -1.5,  2.7,  3.3, -0.8];

% Initialize layers
layer1 = Layer_Dense_constructor(4, 5);
layer2 = Layer_Dense_constructor(5, 2);

% Perform forward pass through the neural network
layer1 = layer1.forward(X);
%disp(layer1.output)
layer2 = layer2.forward(layer1.output);
disp(layer2.output)





%% Function Definitions

% 
% MATLAB supports class definitions however, it requires each class to be
% declared in a separate file on its own. For the purposes of this
% tutorial we want all necessary data structures to be in one file, so we
% are going to use a similar structure - the MATLAB struct
% 
function layer = Layer_Dense_constructor(n_inputs, n_neurons)

% Throw error if the initializer is called with the wrong number of inputs
if nargin < 2, error('Initialization requires input and layer size'); end

% Initialize the layer as a blank struct
layer = struct();
% 
% Initialize the random weight matrix
layer.weights = 0.10 * rand(n_inputs, n_neurons);
% 
% Initialize the bias row vector
layer.biases = zeros(1, n_neurons);
% 
% Initialize the output as a dummy value meant to be overwritten before
% use
layer.output = nan;
% 
% Define the forward pass to use a custom function (defined below)
layer.forward = @(inputs) forward(layer, inputs);


    % Custom forward pass function is needed because the struct cannot
    % directly modify other properties
    function layer = forward(layer, inputs)
        % Return a copy of the current layer with an updated output matrix
        % based on the inputs
        layer.output = inputs * layer.weights + layer.biases;
    end
end
