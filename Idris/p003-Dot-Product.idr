import Data.Vect

inputs : Vect 4 Double
inputs = [1.0, 2.0, 3.0, 2.5]

weights : Vect 3 (Vect 4 Double)
weights = [[0.2, 0.8, -0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.87]]

biases : Vect 3 Double
biases = [2.0, 3.0, 0.5]

-- NOTE: match numpy interface in the spirit of the Python lesson
dotProduct : Vect n (Vect m Double) -> 
             Vect m Double -> 
             Vect n Double
dotProduct xss ys = map (\xs => sum $ zipWith (*) xs ys) xss

-- add the biases to the results of the dot product
output : Vect 3 Double
output = zipWith (+) (dotProduct weights inputs) biases 

main : IO ()
main = printLn output
