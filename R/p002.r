inputs <- c(1, 2, 3, 2.5)
weights1 <- c(0.2, 0.8, -0.5, 1.0)
weights2 <- c(0.5, -0.91, 0.26, -0.5)
weights3 <- c(-0.26, -0.27, 0.17, 0.87)
bias1 <- 2
bias2 <- 3
bias3 <- 0.5

output <- c(inputs[1] * weights1[1] + inputs[2] * weights1[2] + inputs[3] * weights1[3] + inputs[4] * weights1[4] + bias1,
            inputs[1] * weights2[1] + inputs[2] * weights2[2] + inputs[3] * weights2[3] + inputs[4] * weights2[4] + bias2,
            inputs[1] * weights3[1] + inputs[2] * weights3[2] + inputs[3] * weights3[3] + inputs[4] * weights3[4] + bias3)
output
