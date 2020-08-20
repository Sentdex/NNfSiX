import Data.Vect

inputs : Vect 3 Double
inputs = [1.2, 5.1, 2.1]

weights : Vect 3 Double
weights = [3.1, 2.1, 8.7]

bias : Double
bias = 3.0

-- NOTE: this is not the idiomatic way to implement this.  This follows
-- the spirit of the Python lesson, which aims for simplicity and clarity.
output : Double
output = (index 0 inputs)*(index 0 weights) +
         (index 1 inputs)*(index 1 weights) +
         (index 2 inputs)*(index 2 weights) + bias

main : IO ()
main = printLn output
