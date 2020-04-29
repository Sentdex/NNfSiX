multWeights :: [Double] -> [Double] -> Double  -> Double
multWeights i w b = sum (zipWith (*) i w) + b

dotProduct :: [Double] -> [[Double]] -> [Double] -> [Double]
dotProduct i ws bs = zipWith (multWeights i) ws bs 

inputs :: [Double]
inputs = [1.0, 2.0, 3.0, 2.5]

weights :: [[Double]]
weights = [[0.2, 0.8, -0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.87]]

biases :: [Double]
biases = [2.0, 3.0, 0.5]

output = dotProduct inputs weights biases

main = print output