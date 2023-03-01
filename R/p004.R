#part 1 introduction ####
##create inputs
inputs <- c(1,2,3,2.5)
inputs <- matrix(inputs, ncol = 4) 
inputs

##create weights
weights <- c(
  c(0.2, 0.8, -0.5, 1.0),
  c(0.5, -0.91, 0.26, -0.5),
  c(-0.26, -0.27, 0.17, 0.87)
)

weights <- matrix(weights, ncol = 4, byrow = T) #change into matrix for easier dot product, use byrow = TRUE to get the familiar shape in the tutorial
weights <- t(weights) # transpose the weights (this can also be obtained by removing byrow = TRUE in the previous line)
weights

##create biases
biases <- c(2,3,0.5)
biases <- matrix(biases, ncol = 3, byrow = T)
biases

#create output
outputs <- (inputs %*% weights) + biases
outputs <- inputs %*% weights
outputs

## part 2: multiple inputs ####
#create more inputs
multiple_inputs <- c(
  c(1,2,3,2.5),
  c(2.0,5.0,-1.0,2.0),
  c(-1.5,2.7,3.3,-0.8)
)
multiple_inputs <- matrix(multiple_inputs, ncol = 4, byrow = T)
multiple_inputs

# we still use the same weights as defined in part 1, but for the new layer (layer 2) we will define new weights
weights # weights layer 1 as previously defined

weights2 <- c(
  c(0.1,-0.14,0.5),
  c(-0.5, 0.12, -0.33),
  c(-0.44, 0.73, -0.13)
) #notice how the weights changed in dimension (3,3) relative to the first set of weights (3,4). This is because of the three outputs of the first layer
weights2 <- matrix(weights2, ncol = 3, byrow = T)
weights2 <- t(weights2)
weights2

#adjust biases of the first layer, because of the greater output and because R doesn't do well summing with one-array matrices. So we got to duplicate the biases for every array of outcomes
biases1 <- c(2,3,0.5)
biases1 <- matrix(rep(biases1,3), ncol = 3, byrow = T)
biases1

#create new set of biases for the second layer
biases2 <- c(-1, 2, -0.5)
biases2 <- matrix(rep(biases2, 3), ncol = 3, byrow = T)
biases2

#define new output line: layer1_outputs
layer1_outputs <- multiple_inputs %*% weights + biases1
layer1_outputs

#give output of layer 1 as input into layer 2 and give the respective weights and biases
layer2_outputs <- layer1_outputs %*% weights2 + biases2

#show output of layer 2
layer2_outputs

## Part 3 create object class ####
#create more inputs
set.seed(115)
X <- matrix(
  c(1,2,3,2.5,
    2.0,5.0,-1.0,2.0,
    -1.5,2.7,3.3,-0.8),
  nrow = 3, ncol = 4, byrow = T)
X

#define class
setClass("DenseLayer", slots = c(n_inputs = 'numeric', n_neurons = 'numeric'))

#set init (constructor)
setGeneric('init', function(layer) standardGeneric('init'))

#set method for init
setMethod('init', 'DenseLayer',
          function(layer) {
            n_weights <- layer@n_inputs * layer@n_neurons
            weights <- matrix(rnorm(n_weights),
                              nrow = layer@n_inputs,
                              ncol = layer@n_neurons
            )
            attr(layer, 'weights') <- 0.10 * weights
            attr(layer, 'biases') <- rep(0, layer@n_neurons)
            layer
          })

#set method for forward function
setGeneric('forward', function(layer, inputs) standardGeneric('forward'))
setMethod('forward', 'DenseLayer',
          function(layer, inputs){
            attr(layer, 'outputs') <- inputs %*% layer@weights + layer@biases
            layer
          })

#create wrapper for initializing layer object
LayerDense <- function(n_inputs, n_neurons){
  init(new('DenseLayer', n_inputs=n_inputs, n_neurons=n_neurons))
}

#create first layer
layer1 <- LayerDense(n_inputs = 4, n_neurons = 5)

layer1 <- forward(layer1, X)

layer1@outputs

#create second layer
layer2 <- LayerDense(n_inputs = 5, n_neurons = 10)

layer2 <- forward(layer2, layer1@outputs)

layer2@outputs