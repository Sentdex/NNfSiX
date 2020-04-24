/*
Create a basic neuron layer with dot product in Java

Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
*/

import java.util.Arrays;

public class P003DotProduct {
  public static void main(String[] args) {
    double[] inputs = { 1.0, 2.0, 3.0, 2.5 };

    double[][] weights = {
      { 0.2, 0.8, -0.5, 1 },
      { .5, -0.91, 0.26, -0.5 },
      { -0.26, -0.27, 0.17, 0.87 }
    };

    double[] biases = { 2, 3, 0.5 };

    System.out.println(Arrays.toString(add(dotProduct(weights, inputs), biases)));
  }

  private static double[] dotProduct(double[][] input1, double[] input2) {
    double[] outputs = new double[input1.length];

    for (int i = 0; i < input1.length; i++) {
      double output = 0;
      for (int j = 0; j < input2.length; j++) {
        output += input1[i][j] * input2[j];
      }
      outputs[i] = output;
    }

    return outputs;
  }

  private static double[] add(double[] input1, double[] input2) {
    double[] output = new double[input1.length];

    for (int i = 0; i < input1.length; i++) {
      output[i] = input1[i] + input2[i];
    }

    return output;
  }
}
