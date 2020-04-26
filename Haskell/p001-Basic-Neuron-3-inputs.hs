multWeights :: [Double] -> [Double]  -> Double
multWeights inputs weights = sum $ zipWith (*) inputs weights

inputs :: [Double]
inputs = [1.2, 5.1, 2.1]

weights :: [Double]
weights = [3.1, 2.1, 8.7]

bias :: Double
bias = 3.0

output :: Double
output = multWeights inputs weights + bias

main = print output