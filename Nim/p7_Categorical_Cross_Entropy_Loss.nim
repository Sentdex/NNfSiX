# calculating error / how wrong is the model
# using Categorical Cross-Entropy
# video ref: https://youtu.be/dEXPMQXoiLc

import math

# # log is solving for x:
# # E to the power of x = b

# var b = 5.2
# echo ln(b) # 1.648658625587382
# echo pow(E,1.648658625587382) # 5.200000000000002

var softmaxOutput = [0.7, 0.1, 0.2]
var targetClass = 0 # imaginary scenario where target class was 0
var targetOutput = [1.0, 0.0, 0.0] # One-hot vector, index 0 is 'hot'

var loss = -(ln(softmaxOutput[0]) * targetOutput[0] +
            ln(softmaxOutput[1]) * targetOutput[1] +
            ln(softmaxOutput[2]) * targetOutput[2])

echo loss # 0.3566749439387324
loss = -ln(softmaxOutput[0])
echo loss # 0.3566749439387324
echo -ln(0.7) # 0.3566749439387324

# what if prediction was 0.5
echo -ln(0.5) # 0.6931471805599453