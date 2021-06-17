using Statistics

### From Previous Tutorials ###

mutable struct Layer_Dense
    weights::Array{Float64, 2}
    biases::Array{Float64}
end

function Layer_Dense(n_inputs::Int, n_neurons::Int)
    weights = .1 * randn(n_inputs, n_neurons)
    biases = zeros(n_neurons)
    return Layer_Dense(weights, biases)
end

function forward(layer::Layer_Dense, inputs)
    return inputs * layer.weights .+ layer.biases'
end

function Activation_ReLU(inputs)
    return max.(inputs, 0)
end

function Activation_Softmax(inputs)
    exp_values = exp.(inputs .- maximum(inputs, dims=2))
    norm_values = exp_values ./ sum(exp_values, dims=2)
    return norm_values
end

function spiral_data(points::Int, classes::Int)
    X = zeros(Float64, points * classes, 2)
    y = zeros(Int64, points * classes)
    for class_number ∈ 1:classes
        ix = points * (class_number-1)+1:points * class_number
        r = range(0.0, step=1, length=points)
        t = range((class_number-1)*4, class_number*4, length=points) .+ randn(points)*.2
        @. X[ix, :] = [r*sin(t*2.5) r*cos(t*2.5)]
        @. y[ix] = class_number
    end
    return X, y
end

### This tutorial ###

function Loss_CategoricalCrossentropy(y_pred, y_true)
    samples = size(y_pred)[1]
    y_pred_clipped = clamp.(y_pred, 1e-7, 1-1e-7)
    
    if length(size(y_true)) == 1
        correct_confidences = [y_pred_clipped[i, y_true[i]] for i ∈ 1:samples] 
    else
        length(size(y_true)) == 2
        correct_confidences = sum(y_pred_clipped .* y_true, dims=2)
    end
    negative_log_likelihoods = -log.(correct_confidences)
    # return negative_log_likelihoods

    # return the mean of neg_log_lik, because we don't have
    # a dedicated Loss Class, like in the original tutorial
    return mean(negative_log_likelihoods)
end



(X, y) = spiral_data(100, 3)
dense1 = Layer_Dense(2, 3)
dense2 = Layer_Dense(3, 3)

output1 = forward(dense1, X)
activation_output1 = Activation_ReLU(output1)
output2 = forward(dense2, activation_output1)
activation_output2 = Activation_Softmax(output2)

loss = Loss_CategoricalCrossentropy(activation_output2, y)