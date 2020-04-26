#include <iostream>
#include <math.h>

#define NUM_INPUTS 4
#define NUM_OUTPUTS 3

__global__
void dot(int outputs, int inputs, float *M, float *v, float *u){
  int index = threadIdx.x;
  int stride = blockDim.x;
  for (int j = index; j < outputs; j += stride){
    u[j] = 0.0f;
    for(int i = 0; i < inputs; i++){
      u[j] += M[i + inputs*j]*v[i];
    }
  }
}

__global__
void add(int n, float *u, float *v){
  int index = threadIdx.x;
  int stride = blockDim.x;
  for (int i = index; i < n; i += stride){
    u[i] = u[i] + v[i];
  }
}

int main() {
  float *inputs, *weights, *bias, *output;

  cudaMallocManaged(&inputs, NUM_INPUTS*sizeof(float));
  cudaMallocManaged(&weights, NUM_INPUTS*NUM_OUTPUTS*sizeof(float));
  cudaMallocManaged(&bias, NUM_OUTPUTS*sizeof(float));
  cudaMallocManaged(&output, NUM_OUTPUTS*sizeof(float));

  inputs[0] = 1.0f;
  inputs[1] = 2.0f;
  inputs[2] = 3.0f;
  inputs[3] = 2.5f;

  weights[0 + NUM_INPUTS*0] = 0.2f; //indexing as [x, y] = [x + NUM_INPUTS*y]
  weights[1 + NUM_INPUTS*0] = 0.8f;
  weights[2 + NUM_INPUTS*0] = -0.5f;
  weights[3 + NUM_INPUTS*0] = 1.0f;

  weights[0 + NUM_INPUTS*1] = 0.5f;
  weights[1 + NUM_INPUTS*1] = -0.91f;
  weights[2 + NUM_INPUTS*1] = 0.26f;
  weights[3 + NUM_INPUTS*1] = -0.5f;

  weights[0 + NUM_INPUTS*2] = -0.26f;
  weights[1 + NUM_INPUTS*2] = -0.27f;
  weights[2 + NUM_INPUTS*2] = 0.17f;
  weights[3 + NUM_INPUTS*2] = 0.87f;

  bias[0] = 2.0f;
  bias[1] = 3.0f;
  bias[2] = 0.5f;

  dot<<<1, NUM_OUTPUTS>>>(NUM_OUTPUTS, NUM_INPUTS, weights, inputs, output);
  add<<<1, NUM_OUTPUTS>>>(NUM_OUTPUTS, output, bias);
  cudaDeviceSynchronize();


  std::cout << "[" << output[0] << ", " << output[1] << ", " << output[2] << "]" << std::endl;

  cudaFree(inputs);
  cudaFree(weights);
  cudaFree(bias);
  cudaFree(output);
}
