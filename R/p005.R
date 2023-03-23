## Neural Network from p4 ####
#create more inputs
set.seed(0)
X <- matrix(
  c(1,2,3,2.5,
    2.0,5.0,-1.0,2.0,
    -1.5,2.7,3.3,-0.8),
  nrow = 3, ncol = 4, byrow = T)
X

## part 1: simple activation ####
inputs = c(0,2,-1,3.3,-2.7,1.1,2.2,-100)
outputs = c()

# first method
for (i in inputs){
  if (i>0){
    outputs <- append(outputs, i)
  } else {
    outputs <- append(outputs, 0)
  }
}

# second method
for (i in inputs){
  outputs <- append(outputs, max(0,i))
}

outputs


## part 2: neural network with activation ####
#activation function.
Activation_ReLU <- function(inputs){
  return(pmax(inputs,0))
}

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

Activation_ReLU(layer1@outputs)
