multWeights :: [Double] -> [Double] -> Double  -> Double
multWeights i w b = sum (zipWith (*) i w) + b

layer :: [Double] -> [[Double]] -> [Double] -> [Double]
layer i ws bs = zipWith (multWeights i) ws bs 

inputs :: [Double]
inputs = [1.0, 2.0, 3.0, 2.5]

weights1 :: [Double]
weights1 = [0.2, 0.8, -0.5, 1.0]
weights2 :: [Double]
weights2 = [0.5, -0.91, 0.26, -0.5]
weights3 :: [Double]
weights3 = [-0.26, -0.27, 0.17, 0.87]

weights :: [[Double]]
weights = [weights1, weights2, weights3]

bias1 :: Double
bias1 = 2.0
bias2 :: Double
bias2 = 3.0
bias3 :: Double
bias3 = 0.5

biases :: [Double]
biases = [bias1, bias2, bias3]

output = layer inputs weights biases

main = print output
