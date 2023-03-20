##part 1 ####
#example outputs
layer_outputs <- c(4.8, 1.21, 2.385)

#exponentiated list of outputs
exp_values <- c()

#exponentiation of the layer outputs to prevent for example negative values
#without losing meaning of difference in outputs
for (output in layer_outputs) {
  exp_values = c(exp_values, exp(output))
}

#show values(expected: 121.510418   3.353485  10.859063)
exp_values

##part 2: normalization####
#get sum of exp. values
norm_base <- sum(exp_values)
norm_base

#insert normalized values of exponential outputs
norm_values <- c()

for (value in exp_values) {
  norm_values <- c(norm_values, value/norm_base)
}

#show normalized output
norm_values

#show that total is 100%
sum(norm_values)

##part 3: functional code####
layer_outputs <- matrix(c(4.8, 1.21, 2.385), ncol=3)
exp_values <- exp(layer_outputs)
norm_values <- exp_values / sum(exp_values)
norm_values

##part 4: ####
layer_outputs <- matrix(c(4.8, 1.21, 2.385,
                          8.9, -1.81, 0.2, 
                          1.41, 1.051, 0.026), ncol = 3,
                        byrow = T)

layer_outputs
matrix(apply(layer_outputs, 1, max))
matrix(mapply("-", layer_outputs, apply(layer_outputs, 1, max)), nrow = ncol(layer_outputs))

exp_values <- exp(layer_outputs)
exp_values

sums_exp <- rowSums(exp_values)
sums_exp

#norm_values <- exp_values / sums_exp

matrix(mapply("/", exp_values, sums_exp), nrow = ncol(exp_values))

##part 5: implement in existing neural network from p005####
#activation function.
Activation_ReLU <- function(inputs){
  return(pmax(inputs,0))
}

Activation_Softmax <- function(inputs){
  exp_values <- exp(matrix(mapply("-", inputs, apply(inputs, 1, max)), ncol = ncol(inputs)))
  probabilities <- matrix(mapply("/", exp_values, rowSums(exp_values)), ncol = ncol(exp_values)) 
  return(probabilities)
}

Activation_Softmax(matrix(c(4,0,3,1,2,3), ncol = 2, byrow = T))

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

#spiral dataset
##define spiral dataset with 4 classes and 200 examples each ####
N <- 100 #number of points per class
D <- 2 #number of dimensions
K <- 3 #number of classes
X <- data.frame() #data matrix
y <- data.frame() #class labels

set.seed(308) #set random seed for testing purposes

##creating dataset ####
for (j in (1:K)){
  r <- seq(0.05, 1, length.out=N) #radius
  t <- seq((j-1)*4.7,j*4.7, length.out=N) + rnorm(N,sd=0.3) #theta ??
  Xtemp <- data.frame(x = r*sin(t), y= r*cos(t))
  ytemp <- data.frame(matrix(j,N,1))
  X <- rbind(X, Xtemp)
  y <- rbind(y, ytemp)
}

data <- cbind(X, y)
colnames(data) <- c(colnames(X), 'label')
data

library(ggplot2)
ggplot() +
  geom_point(data = data, aes(x=x, y=y, color=as.character(label)), size=2) +
  scale_color_discrete(name = 'Label') + coord_fixed(ratio = 0.6) +
  theme(axis.ticks=element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
        axis.text=element_blank(),legend.position = 'none')

#make 'prediction' (no feedback yet, just testing softmax function)
#create first layer
#input is 2, since we have 2 variables (x,y)
layer1 <- LayerDense(n_inputs = 2, n_neurons = 3)
layer1 <- forward(layer1, as.matrix(X))
layer1@outputs

#input is 3, since output of layer 1 is 3 neurons. n_neurons is 3 since we have three classes.
#ReLU activation is initialized here
layer2 <- LayerDense(n_inputs = 3, n_neurons = 3)
layer2 <- forward(layer2, Activation_ReLU(layer1@outputs))

#view first 5 output with softmax activation
head(Activation_Softmax(layer2@outputs))



