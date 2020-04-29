def dot(m : Array(Array(Float64)), v : Array(Float64)) : Array(Float64)
  # here one should check for A[0].size == v.size
  # but this will be left out for simplicity and readability
  i : UInt8 = 0
  j : UInt8 = 0
  u : Array(Float64) = Array.new(m.size, 0.0)
  while (i < u.size)
    j = 0
    while (j < v.size)
      u[i] += m[i][j]*v[j]
      j+=1
    end
    i+=1
  end
  return u
end

def add(v1 : Array(Float64), v2 : Array(Float64)) : Array(Float64)
  # here one should check for v1.size == v2.size
  # but this will be left out for simplicity and readability
  i : UInt8 = 0
  u : Array(Float64) = v1.clone
  u.fill(0)
  while (i < u.size)
    u[i] = v1[i] + v2[i]
    i+=1
  end
  return u
end

# The above replaces the `import numpy as np` ==============

inputs = [1.0_f64, 2.0_f64, 3.0_f64, 2.5_f64]

weights = [[0.2_f64, 0.8_f64, -0.5_f64, 1.0_f64],
            [0.5_f64, -0.91_f64, 0.26_f64, -0.5_f64],
            [-0.26_f64, -0.27_f64, 0.17_f64, 0.87_f64]]

bias = [2.0_f64, 3.0_f64, 0.5_f64]

output = add(dot(weights, inputs), bias)
puts output
