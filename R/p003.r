inputs <- c(1.0, 2.0, 3.0, 2.5);

weights <- matrix(
            c(0.2, 0.8, -0.5, 1.0, 0.5, -0.91, 0.26, -0.5, -0.26, -0.27, 0.17, 0.87),
            nrow = 3,
            ncol = 4,
            byrow = TRUE
          );

biases <- c(2.0, 3.0, 0.5)

product <- inputs %*% t(weights);
result <- product + biases

print(result)
