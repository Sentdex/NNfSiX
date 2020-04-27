#include <iostream>
#include <math.h>

int main() {
  float *inputs, *weights, *bias, *output;

  cudaMallocManaged(&inputs, 3*sizeof(float));
  cudaMallocManaged(&weights, 3*sizeof(float));
  cudaMallocManaged(&bias, sizeof(float));
  cudaMallocManaged(&output, sizeof(float));

  inputs[0] = 1.0f;
  inputs[1] = 2.0f;
  inputs[2] = 3.0f;

  weights[0] = 3.1f;
  weights[1] = 2.1f;
  weights[2] = 8.7f;

  bias[0] = 3.0f;

  output[0] = inputs[0] * weights[0] + inputs[1] * weights[1] +
                 inputs[2] * weights[2] + bias[0];

  std::cout << output[0] << std::endl;

  cudaFree(inputs);
  cudaFree(weights);
  cudaFree(bias);
  cudaFree(output);
}
