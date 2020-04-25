func dot(m:[[Double]], v:[Double]) -> [Double] {
  // here one should check for A[0].count == v.count
  // but this will be left out for simplicity and readability
  var u:[Double] = Array(repeating: 0.0, count: m.count)

  for i in 0...(m[0].count-1) {
    for j in 0...(m.count-1) {

      u[j] += m[j][i]*v[i]

    }
  }

  return u
}

func add(v1:[Double], v2:[Double]) -> [Double]{
  // here one should check for v1.count == v2.count
  // but this will be left out for simplicity and readability
  var u:[Double] = Array(repeating: 0.0, count: v1.count)

  for i in 0...(v1.count-1) {

    u[i] = v1[i] + v2[i]

  }

  return u
}

// The above replaces the `import numpy as np` =========

var inputs:[Double] = [1.0, 2.0, 3.0, 2.5]
var weights:[[Double]] = [[0.2, 0.8, -0.5, 1.0],
                          [0.5, -0.91, 0.26, -0.5],
                          [-0.26, -0.27, 0.17, 0.87]]

var biases:[Double] = [2.0, 3.0, 0.5]

var output:[Double] = dot(m: weights, v: inputs)
output = add(v1: output, v2: biases)
print(output)
