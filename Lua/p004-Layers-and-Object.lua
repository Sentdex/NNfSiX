-- Matrix Module
local Matrix = {}
Matrix.__index = Matrix

-- Constructors {
function Matrix.new(rows, cols, value)
	local fillValue = value or 0
	local mat = table.create(rows, table.create(cols, fillValue))
	setmetatable(mat, Matrix)
	return mat
end

function Matrix.from1DArray(arr)
	local rows, cols = #arr, 1
	local mat = {}
	for i = 1, rows do
		mat[i] = {}
		for j = 1, cols do
			mat[i][j] = arr[i]
		end
	end
	setmetatable(mat, Matrix)
	return mat
end

function Matrix.from2DArray(arr)
	local rows, cols = #arr, #arr[1]
	local mat = {}
	for i = 1, rows do
		mat[i] = {}
		for j = 1, cols do
			mat[i][j] = arr[i][j]
		end
	end
	setmetatable(mat, Matrix)
	return mat
end

function Matrix.random(rows, cols, min, max)
	min = min or 0
	max = max or 1
	local mat = {}
	for i = 1, rows do
		mat[i] = {}
		for j = 1, cols do
			mat[i][j] = math.random() * (max - min) + min
		end
	end
	setmetatable(mat, Matrix)
	return mat
end

-- Mathematical Functions
function Matrix.dot(matA, matB)
	local rowsB, colsA = #matB, #matA[1]
	local rowsA, colsB = #matA, #matB[1]
	local res = {}
	for i = 1, rowsA do
		res[i] = {}
		for j = 1, colsB do
			local sum = 0
			for k = 1, colsA do
				sum = sum + matA[i][k] * matB[k][j]
			end
			res[i][j] = sum
		end
	end
	setmetatable(res, Matrix)
	return res
end

function Matrix.__add(matA, matB)
	local rowsA, colsA = #matA, #matA[1]
	local rowsB, colsB = #matB, #matB[1]
	local res = {}
	if colsA == colsB then
		if rowsA == rowsB then
			for i = 1, rowsA do
				res[i] = {}
				for j = 1, colsA do
					res[i][j] = matA[i][j] + matB[i][j]
				end
			end
		elseif rowsB == 1 then
			for i = 1, rowsA do
				res[i] = {}
				for j = 1, colsA do
					res[i][j] = matA[i][j] + matB[1][j]
				end
			end
		end
	elseif colsB == 1 then
		for i = 1, rowsA do
			res[i] = {}
			for j = 1, colsA do
				res[i][j] = matA[i][j] + matB[j][1]
			end
		end
	end
	setmetatable(res, Matrix)
	return res
end

function Matrix.__sub(matA, matB)
	local rowsA, colsA = #matA, #matA[1]
	local rowsB, colsB = #matB, #matB[1]
	local res = {}
	if colsA == colsB then
		if rowsA == rowsB then
			for i = 1, rowsA do
				res[i] = {}
				for j = 1, colsA do
					res[i][j] = matA[i][j] - matB[i][j]
				end
			end
		elseif rowsB == 1 then
			for i = 1, rowsA do
				res[i] = {}
				for j = 1, colsA do
					res[i][j] = matA[i][j] - matB[1][j]
				end
			end
		end
	elseif colsB == 1 then
		for i = 1, rowsA do
			res[i] = {}
			for j = 1, colsA do
				res[i][j] = matA[i][j] - matB[j][1]
			end
		end
	end
	setmetatable(res, Matrix)
	return res
end

local function hadamardProduct(matA, matB)
	local res = {}
	local rowsA, colsA = #matA, #matA[1]
	if colsA ~= #matB[1] then
		error("Invalid matrix shape")
	end
	for i = 1, rowsA do
		res[i] = {}
		for j = 1, colsA do
			res[i][j] = matA[i][j] * matB[i][j]
		end
	end
	setmetatable(res, Matrix)
	return res
end

local function scalarMultiply(mat, num)
	local res = {}
	local rows, cols = #mat, #mat[1]
	for i = 1, rows do
		res[i] = {}
		for j = 1, cols do
			res[i][j] = mat[i][j] * num
		end
	end
	setmetatable(res, Matrix)
	return res
end

function Matrix.__mul(matA, matB)
	if typeof(matA) == "table" then
		if typeof(matB) == "table" then
			return hadamardProduct(matA, matB)
		elseif typeof(matB) == "number" then
			return scalarMultiply(matA, matB)
		end
	elseif typeof(matA) == "number" and typeof(matB) == "table" then
		return scalarMultiply(matB, matA)
	end
	error("Invalid matrices or scalar provided")
end

function Matrix.__div(matA, matB)
	local rowsA, colsA = #matA, #matA[1]
	local rowsB, colsB = #matB, #matB[1]
	local res = {}
	if colsA == colsB then
		if rowsA == rowsB then
			for i = 1, rowsA do
				res[i] = {}
				for j = 1, colsA do
					res[i][j] = matA[i][j] / matB[i][j]
				end
			end
		elseif rowsB == 1 then
			for i = 1, rowsA do
				res[i] = {}
				for j = 1, colsA do
					res[i][j] = matA[i][j] / matB[1][j]
				end
			end
		end
	elseif colsB == 1 then
		for i = 1, rowsA do
			res[i] = {}
			for j = 1, colsA do
				res[i][j] = matA[i][j] / matB[j][1]
			end
		end
	end
	setmetatable(res, Matrix)
	return res
end

-- Helpful functions
function Matrix.T(mat) -- Tranpose
	local rows, cols = #mat, #mat[1]
	local res = {}
	for i = 1,  cols do
		res[i] = {}
		for j = 1, rows do
			res[i][j] = mat[j][i]
		end
	end
	setmetatable(res, Matrix)
	return res
end

function Matrix.__tostring(mat)
	local rows, cols = #mat, #mat[1]
	local str = "{"
	for i = 1, rows do
		str = str.."{"
		for j = 1, cols do
			str = str..mat[i][j]
			if j < cols then
				str = str..", "
			end
		end
		str = str.."}"
		if i < rows then
			str = str..",\n"
		end
	end
	str = str.."}"
	return str
end

-- Dense Layer Module
local mat = require(script.Parent.Matrix)

local Layer_Dense = {}
Layer_Dense.__index = Layer_Dense

Layer_Dense.new = function(n_inputs, n_neurons)
	local layer = {
		weights = 0.1 * mat.random(n_inputs, n_neurons, -1, 1),
		biases = mat.new(1, n_neurons, 0),
		output = {}
	}
	setmetatable(layer, Layer_Dense)
	return layer
end

function Layer_Dense:forward(inputs)
	self.output = mat.dot(inputs, self.weights) + self.biases
end

-- Code from video
local mat = require(script.Matrix)
local Layer_Dense = require(script.DenseLayer)

local X = mat.from2DArray({
	{1, 2, 3, 2.5},
	{2.0, 5.0, -1.0, 2.0},
	{-1.5, 2.7, 3.3, -0.8}
})

local layer1 = Layer_Dense.new(4, 5)
local layer2 = Layer_Dense.new(5, 2)

layer1:forward(X)
layer2:forward(layer1.output)
print(layer2.output)
