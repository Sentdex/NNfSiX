#include <iostream>
#include <math.h>

int main() {
  float *inputs, *weights1, *bias1, *weights2, *bias2, *weights3, *bias3, *output;

  cudaMallocManaged(&inputs, 4*sizeof(float));
  cudaMallocManaged(&weights1, 4*sizeof(float));
  cudaMallocManaged(&bias1, sizeof(float));
  cudaMallocManaged(&weights2, 4*sizeof(float));
  cudaMallocManaged(&bias2, sizeof(float));
  cudaMallocManaged(&weights3, 4*sizeof(float));
  cudaMallocManaged(&bias3, sizeof(float));
  cudaMallocManaged(&output, 3*sizeof(float));

  inputs[0] = 1.0f;
  inputs[1] = 2.0f;
  inputs[2] = 3.0f;
  inputs[3] = 2.5f;

  weights1[0] = 0.2f;
  weights1[1] = 0.8f;
  weights1[2] = -0.5f;
  weights1[3] = 1.0f;
  weights2[0] = 0.5f;
  weights2[1] = -0.91f;
  weights2[2] = 0.26f;
  weights2[3] = -0.5f;
  weights3[0] = -0.26f;
  weights3[1] = -0.27f;
  weights3[2] = 0.17f;
  weights3[3] = 0.87f;

  bias1[0] = 2.0f;
  bias2[0] = 3.0f;
  bias3[0] = 0.5f;

  output[0] = inputs[0]*weights1[0] + inputs[1]*weights1[1] + inputs[2]*weights1[2] + bias1[0];
  output[1] = inputs[0]*weights2[0] + inputs[1]*weights2[1] + inputs[2]*weights2[2] + bias2[0];
  output[2] = inputs[0]*weights3[0] + inputs[1]*weights3[1] + inputs[2]*weights3[2] + bias3[0];

  std::cout << "[" << output[0] << ", " << output[1] << ", " << output[2] << "]" << std::endl;

  cudaFree(inputs);
  cudaFree(weights1);
  cudaFree(bias1);
  cudaFree(weights2);
  cudaFree(bias2);
  cudaFree(weights3);
  cudaFree(bias3);
  cudaFree(output);
}
