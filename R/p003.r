library("pracma")

inputs <- c(1, 2, 3, 2.5)

weights <- list( c(0.2, 0.8, -0.5, 1.0), 
                 c(0.5, -0.91, 0.26, -0.5), 
                 c(-0.26, -0.27, 0.17, 0.87))

biases <- c(2,3,0.5)

output <- dot(do.call(cbind, weights), inputs) + biases
print(output)
