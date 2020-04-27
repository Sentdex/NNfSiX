multWeights :: [Double] -> [Double] -> Double  -> Double
multWeights inputs weights bias = sum  (zipWith (*) inputs weights) + bias

inputs :: [Double]
inputs = [1.2, 5.1, 2.1]

weights :: [Double]
weights = [3.1, 2.1, 8.7]

bias :: Double
bias = 3.0

output :: Double
output = multWeights inputs weights bias

main = print output