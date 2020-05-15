#=
Associated YT tutorial: https://youtu.be/gmjzbpSVY1A
=#

using Random

Random.seed!(0)

# Define the spiral_data function to get some data.
function spiral_data(points::Int, classes::Int)
    X = zeros(Float64, points * classes, 2)
    y = zeros(Int64, points * classes)
    for class_number = 1:classes
        ix = points*(class_number-1)+1:points*class_number
        r = range(0, 1, length=points)
        t = range((class_number-1)*4, class_number*4, length=points) .+ randn(points)*0.2
        # The @. macro makes all calculations element-wise.
        @. X[ix, :] = [r*sin(t*2.5) r*cos(t*2.5)]
        @. y[ix] = class_number
    end
    return X, y
end
(X, y) = spiral_data(100, 3)


# Julia doesn't have classes, so instead we make a struct.
mutable struct Layer_Dense
    weights::Array{Float64, 2}
    biases::Vector{Float64}
end

# Make a constructor for this struct.
function Layer_Dense(n_inputs, n_neurons)
    weights = 0.10 * randn(n_inputs, n_neurons)
    biases = zeros(n_neurons)

    return Layer_Dense(weights, biases)
end

# And define the forward function for this struct.
function forward(layer::Layer_Dense, inputs)
    return inputs * layer.weights .+ layer.biases'
end

# The rectified linear unit.
function activation_ReLU(inputs)
    # Using the dot to take the element-wise maximum.
    return max.(0., inputs)
end

# Now do the example.
layer1 = Layer_Dense(2, 5)

output1 = forward(layer1, X)
activation_output1 = activation_ReLU(output1)

println(activation_output1)
