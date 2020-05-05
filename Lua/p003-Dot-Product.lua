local Matrix = {}
Matrix.__index = Matrix

-- Constructors {
function Matrix.new(rows: number, cols: number, value: number?)
	local fillValue = value or 0
	local mat = table.create(rows, table.create(cols, fillValue))
	setmetatable(mat, Matrix)
	return mat
end

function Matrix.from1DArray(arr: {[number]: number})
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

function Matrix.from2DArray(arr: {[number]: {[number]: number}})
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

-- Mathematical Functions

function Matrix.dot(matA, matB)
	local rowsB, colsA = #matB, #matA[1]
	if colsA ~= rowsB then
		error("Invalid matrix size")
	end
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
	if rowsA ~= #matB or colsA ~= #matB[1] then
		error("Invalid matrix size")
	end
	local res = {}
	for i = 1, rowsA do
		res[i] = {}
		for j = 1, colsA do
			res[i][j] = matA[i][j] + matB[i][j]
		end
	end
	setmetatable(res, Matrix)
	return res
end

function Matrix.__sub(matA, matB)
	local rowsA, colsA = #matA, #matA[1]
	if rowsA ~= #matB or colsA ~= #matB[1] then
		error("Invalid matrix size")
	end
	local res = {}
	for i = 1, rowsA do
		res[i] = {}
		for j = 1, colsA do
			res[i][j] = matA[i][j] - matB[i][j]
		end
	end
	setmetatable(res, Matrix)
	return res
end

function Matrix.__mul(matA, matB)
	local rowsA, colsA = #matA, #matA[1]
	if rowsA ~= #matB or colsA ~= #matB[1] then
		error("Invalid matrix size")
	end
	local res = {}
	for i = 1, rowsA do
		res[i] = {}
		for j = 1, colsA do
			res[i][j] = matA[i][j] * matB[i][j]
		end
	end
	setmetatable(res, Matrix)
	return res
end

function Matrix.__div(matA, matB)
	local rowsA, colsA = #matA, #matA[1]
	if rowsA ~= #matB or colsA ~= #matB[1] then
		error("Invalid matrix size")
	end
	local res = {}
	for i = 1, rowsA do
		res[i] = {}
		for j = 1, colsA do
			res[i][j] = matA[i][j] / matB[i][j]
		end
	end
	setmetatable(res, Matrix)
	return res
end

-- Helpful functions
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

-- Code from video in Lua
local mat = require(script.Matrix)

local inputs = mat.from1DArray({1, 2, 3, 2.5})
local weights = mat.from2DArray({
	{0.20, 0.80, -0.50, 1.00},
	{0.50, -0.91, 0.26, -0.50},
	{-0.26, -0.27, 0.17, 0.87}
})
local biases = mat.from1DArray({2, 3, 0.5})

local output = mat.dot(weights, inputs) + biases
print(tostring(output))
