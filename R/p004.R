set.seed(0)

X = matrix(
    c(1.0, 2.0, 3.0, 2.5,
      2.0, 5.0,-1.0, 2.0,
      -1.5, 2.7, 3.3,-0.8),
    nrow = 3, ncol = 4, byrow = TRUE
)

# define dense layer class 
setClass("LayerDense", slots = list(n_inputs="numeric", n_neurons="numeric"))

# make constructor 
setGeneric("init", function(layer) standardGeneric("init"))
setMethod("init", "LayerDense",
          function(layer) {
              number_rands <- layer@n_inputs*layer@n_neurons
              weight_matrix <- matrix(rnorm(number_rands), 
                                      layer@n_inputs, layer@n_neurons)
              attr(layer, "weights") <- 0.10 * weight_matrix
              attr(layer, "biases") <- rep(0, layer@n_neurons)
              layer
          })

# define forward pass function 
setGeneric("forward", function(layer, inputs) standardGeneric("forward"))
setMethod("forward", "LayerDense",
          function(layer, inputs) {
              attr(layer, "output") <- inputs %*% layer@weights + layer@biases
              layer 
          })

# create wrapper for initializing layer object 
LayerDense <- function(n_inputs, n_neurons) {
    init(new("LayerDense", n_inputs=n_inputs, n_neurons=n_neurons))
}

# create layers 
layer1 <- LayerDense(n_inputs = 4, n_neurons = 5)
layer2 <- LayerDense(n_inputs = 5, n_neurons = 2)

layer1 <- forward(layer1, X)
layer2 <- forward(layer2, layer1@output)

print(layer2@output)