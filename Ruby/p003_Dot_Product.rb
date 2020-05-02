# Doing dot product with a layer of neurons and multiple inputs
# Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4

def dotProduct(l1, l2)
	output = []
	for i in 0 ... l1.size
		sum = 0
		for j in 0 ... l2.size
			sum += l1[i][j] * l2[j]
		end
		output << sum
	end

	return output
end


inputs = [1.0, 2.0, 3.0, 2.5]
weights = [[0.2, 0.8, -0.5, 1.0],
           [0.5, -0.91, 0.26, -0.5],
           [-0.26, -0.27, 0.17, 0.87]]

biases = [2.0, 3.0, 0.5]

output = dotProduct(weights, inputs)

for i in 0 ... biases.size
	output[i] = output[i] + biases[i]
end

print output
