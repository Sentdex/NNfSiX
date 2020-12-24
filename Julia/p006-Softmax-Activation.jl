# Code to match https://www.youtube.com/watch?v=omz_NdFgWyU&list=PLQVvvaa0QuDcjD5BAw2DxE6OF2tius3V3&index=6

# Usings.
using Random
Random.seed!(0)

##############################
# Stuff from previous videos #
##############################

# Define the spiral_data function to get some data.
function spiral_data(points::Int, classes::Int)

    X = zeros(Float64, points * classes, 2)
    y = zeros(Int64, points * classes)

    for class_number = 1:classes

        ix = points*(class_number-1)+1:points*class_number
        r = range(0, 1, length=points)
        t = range((class_number-1)*4, class_number*4, length=points) .+ randn(points)*0.2

        @. X[ix, :] = [r*sin(t*2.5) r*cos(t*2.5)]
        @. y[ix] = class_number
    end

    return X, y
end

# Struct for a layer.
mutable struct Layer_Dense
    weights::Array{Float64, 2}
    biases::Vector{Float64}
end

# Make a constructor for this struct.
function Layer_Dense(n_inputs::Int, n_neurons::Int)
    weights = 0.10 * randn(n_inputs, n_neurons)
    biases = zeros(n_neurons)

    return Layer_Dense(weights, biases)
end

# And define the forward function for this struct.
function forward(layer::Layer_Dense, inputs)
    return inputs * layer.weights .+ layer.biases'
end

# The rectified linear unit.
function activation_relu(inputs)
    # Using the dot to take the element-wise maximum.
    return max.(0., inputs)
end


#############
# New stuff #
#############

# The softmax activation function.
function activation_softmax(x)

    # Protect against overflow.
    x .-= maximum(x, dims=2)

    exp_values = exp.(x)
    return exp_values ./ sum(exp_values, dims=2)
end


###############
# The example #
###############
X, y = spiral_data(100, 3)

dense1 = Layer_Dense(2, 3)
dense2 = Layer_Dense(3, 3)

output1 = forward(dense1, X)
output1_a = activation_relu(output1)

output2 = forward(dense2, output1_a)
output2_a = activation_softmax(output2)

println(output2_a[1:5, :])
