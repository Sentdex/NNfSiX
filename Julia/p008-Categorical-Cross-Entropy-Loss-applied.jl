"""
Applying Categorical Cross Entropy loss to our NNFS framework
Associated with YT NNFS tutorial: https://www.youtube.com/watch?v=levekYbxauw&list=PLQVvvaa0QuDcjD5BAw2DxE6OF2tius3V3&index=8
"""

# Usings.
using Random
using Statistics
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

# The softmax activation function.
function activation_softmax(x)

    # Protect against overflow.
    x .-= maximum(x, dims=2)

    exp_values = exp.(x)
    return exp_values ./ sum(exp_values, dims=2)
end

#############
# New stuff #
#############

# Loss function. Rather than trying to make a parent Loss struct and then a Loss_CategoricalCrossentropy sub-struct that inherits from it,
# I thought it would make more sense to just make this a regular function.
function Loss_CategoricalCrossentropy(y_pred, y_true)


    samples = length(y_pred)

    y_pred_clipped = clamp.(y_pred,1e-7, 1.0-1e-7)

    if ndims(y_true) == 1
        correct_confidences = [y_pred_clipped[i, y_true[i]] for i in 1:length(y_true)]


    elseif ndims(y_true) == 2
        correct_confidences = sum(y_pred_clipped .* y_true, dims=2)
    end

    negative_log_likelihoods = -log.(correct_confidences)

    mean_loss = mean(negative_log_likelihoods)

    return mean_loss
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

loss = Loss_CategoricalCrossentropy(output2_a, y)
println("Loss: ", loss)


# ## Testing that the loss function also works for one-hot encoding of y_true.

# y_one_hot = zeros(Float64, length(y), 3)
# for i in 1:length(y)
#     y_one_hot[i,y[i]] = 1
# end
# loss = Loss_CategoricalCrossentropy(output2_a, y_one_hot)
# println("Loss: ", loss)

