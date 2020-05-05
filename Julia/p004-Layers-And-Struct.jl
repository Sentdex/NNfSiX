#=
Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
=#

using Random

Random.seed!(0)

X = [ 1    2    3    2.5;
      2.0  5.0 -1.0  2.0;
     -1.5  2.7  3.3 -0.8]


# Julia doesn't have classes, so instead we make a struct.
mutable struct Layer_Dense
    weights::Array{Float64, 2}
    biases::Array{Float64, 2}
    output::Array{Float64, 2}
end

# Make a constructor for this struct.
function Layer_Dense(n_inputs, n_neurons)
    weights = 0.10 * randn(n_inputs, n_neurons)
    biases = zeros(1, n_neurons)

    # Initialize with an undefined output.
    output = Array{Float64, 2}(undef, n_inputs, n_neurons)

    Layer_Dense(weights, biases, output)
end

# And define the forward function for this struct.
function forward(layer::Layer_Dense, inputs)
    layer.output = inputs * layer.weights .+ layer.biases
end

# Now do the example.
layer1 = Layer_Dense(4,5)
layer2 = Layer_Dense(5,2)

forward(layer1, X)
forward(layer2, layer1.output)
println(layer2.output)
