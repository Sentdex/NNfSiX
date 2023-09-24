"""
Calculating the loss with Categorical Cross Entropy
Associated with YT NNFS tutorial: https://www.youtube.com/watch?v=dEXPMQXoiLc
"""

softmax_output = [0.7, 0.1, 0.2]
target_output = [1, 0, 0]



loss = - (log(softmax_output[1]) * target_output[1] +
          log(softmax_output[2]) * target_output[2] +     
          log(softmax_output[3]) * target_output[3])


println(loss)

println(-log(0.7))
println(-log(0.5))