"""
Doing dot product with a layer of neurons and multiple inputs
"""

var inputs = [1.0, 2.0, 3.0, 2.5]
var weights = [[0.2, 0.8, -0.5, 1.0], [0.5, -0.91, 0.26, -0.5], [-0.26, -0.27, 0.17, 0.87]]
var biases = [2.0, 3.0, 0.5]


func _ready():
	# The output function
	var layerOutput = sumArray(dotProduct(inputs, weights), biases)
	print(layerOutput)
	
	
	
func dotProduct(inputs, weights):
	# Iterate through list of list
	var outputTemp = []
	var finalArray = []
	for weight in weights:
		var count = 0   # To use this as an index
		var stageoutput = []   # temporary list
		# Iterate through list
		for weightElement in weight: 
		  stageoutput.append(inputs[count] * weightElement)    
		  count += 1     
		outputTemp.append(stageoutput)
	# Sum the values in the outputTemp list and append to finalArray
	for items in outputTemp:
		finalArray.append(sumofListinList(items))
	return finalArray


func sumArray(array1, array2):
	# Add two same sized arrays
	var count = 0
	var output = []
	if array1.size() == array2.size():
		for item in array1:
			var value = item + array2[count]
			output.append(value)
			count += 1
		return output
	else:
		return "The size of two input arrays do not match."


func sumofListinList(array):
	# Sum values of an array
	var sum = 0
	for items in array:
		sum += items
	return sum
