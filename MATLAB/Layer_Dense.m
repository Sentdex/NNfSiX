% Definition of the Layer_Dense class
%   This file must be in the same directory (or path) as the script using
%   the Layer_Dense class
% 
% Constructor:  Requires: number of input features to the layer,
%                         number of neurons in the layer
%               Modifies: N/A
%               Returns : the Layer_Dense object with intial weights and
%                           biases
% 
% forward:  Requires: Layer_Dense object to be modified,
%                     inputs to the layer
%           Modifies: output
%           Returns : the updated Layer_Dense object


classdef Layer_Dense
    properties
        weights
        biases
        output
    end
    
    methods
        function layer = Layer_Dense(n_inputs, n_neurons)
            if nargin < 2, error('Initialization requires input and layer size'); end
            
            layer.weights = 0.10 * rand(n_inputs, n_neurons);
            layer.biases = zeros(1, n_neurons);
        end
        
        function layer = forward(layer, inputs)
            layer.output = inputs * layer.weights + layer.biases;
        end
    end
end
