import Data.Vect

inputs : Vect 4 Double
inputs = [1.0, 2.0, 3.0, 2.5]

weights1 : Vect 4 Double
weights1 = [0.2, 0.8, -0.5, 1.0]
weights2 : Vect 4 Double
weights2 = [0.5, -0.91, 0.26, -0.5]
weights3 : Vect 4 Double
weights3 = [-0.26, -0.27, 0.17, 0.87]

weights : Vect 3 (Vect 4 Double)
weights = [weights1, weights2, weights3]

bias1 : Double
bias1 = 2.0
bias2 : Double
bias2 = 3.0
bias3 : Double
bias3 = 0.5

-- NOTE: this is not the idiomatic way to implement this.  This follows
-- the spirit of the Python lesson, which aims for simplicity and clarity.
output : Vect 3 Double
output = [
  (index 0 inputs)*(index 0 weights1) + (index 1 inputs)*(index 1 weights1) + (index 2 inputs)*(index 2 weights1) + (index 3 inputs)*(index 3 weights1) + bias1,
  (index 0 inputs)*(index 0 weights2) + (index 1 inputs)*(index 1 weights2) + (index 2 inputs)*(index 2 weights2) + (index 3 inputs)*(index 3 weights2) + bias2,
  (index 0 inputs)*(index 0 weights3) + (index 1 inputs)*(index 1 weights3) + (index 2 inputs)*(index 2 weights3) + (index 3 inputs)*(index 3 weights3) + bias3]

main : IO ()
main = printLn output
