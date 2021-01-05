%you should change the name of file to layflow
classdef layflow

    properties
        output;
        weight;
        bias;
    end
    
    methods
        function obj = layflow(n_input, n_neurons)

            obj.weight = rand(n_input, n_neurons);
            obj.bias = zeros(1, n_neurons);
        end
        
        function obj = forward(obj, input)
           obj.output = input * obj.weight + obj.bias;
            
        end
    end
end

