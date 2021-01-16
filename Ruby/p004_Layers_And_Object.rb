"""
Creates two simple layers of neurons, and feeds forward inputs through them.
Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
"""

require "numo/narray"


X = Numo::DFloat[[1, 2, 3, 2.5],
     [2.0, 5.0, -1.0, 2.0],
     [-1.5, 2.7, 3.3, -0.8]]


class Layer_Dense
    attr_accessor :output

    def initialize( n_inputs, n_neurons)
        @weights = 0.10 * Numo::DFloat.new(n_inputs, n_neurons).rand
        @biases =  Numo::DFloat.zeros(1, n_neurons)
    end

    def forward(inputs)
        @output = inputs.dot(@weights) + @biases
    end

end

layer1 = Layer_Dense.new(4,5)
layer2 = Layer_Dense.new(5,2)

layer1.forward(X)
#puts layer1.output.inspect
layer2.forward(layer1.output)
puts layer2.output.inspect
