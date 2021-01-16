/*
 * Create a dense layer.
 *
 * Associated tutorial https://www.youtube.com/watch?v=TEWy9vZcxW4
 */

import java.util.Arrays;
import java.util.Random;

public class P004LayersAndObjects {
    /**
     * Main method, establishes data to be used, creates two layers and runs data through both layers to get output.
     */
    public static void main(String[] args) {
        double[][] X = {
                {1.0, 2.0, 3.0, 2.5},
                {2.0, 5.0, -1.0, 2.0},
                {-1.5, 2.7, 3.3, -0.8}
        };

        Layer_Dense layer1 = new Layer_Dense(4, 5);
        Layer_Dense layer2 = new Layer_Dense(5, 2);

        layer1.forward(X);
        //System.out.println(Arrays.deepToString(layer1.getOutput()));
        layer2.forward(layer1.getOutput());
        System.out.println(Arrays.deepToString(layer2.getOutput()));
    }
}

class Layer_Dense {
    private static final Random random = new Random(0); //random number generator used for gaussian distribution.
    private double[][] weights; //weights of the layer
    private double[] biases; //biases of the layer
    private double[][] output; // output of the layer.

    /**
     * Constructor for new densely connected layer.
     *
     * @param n_inputs  Number of inputs coming into layer.
     * @param n_neurons Number of neurons in layer.
     */
    public Layer_Dense(int n_inputs, int n_neurons) {
        this.weights = randn(n_inputs, n_neurons);
        this.biases = new double[n_neurons];
    }

    /**
     * Feed forward method used to calculate output of layer.
     *
     * @param inputs Input to be used to calculate output.
     */
    public void forward(double[][] inputs) {
        output = add(dotProduct(inputs, weights), biases);
    }

    /**
     * Get the Output array.
     *
     * @return The output array of the layer;
     */
    public double[][] getOutput() {
        return output;
    }

    /**
     * Implementation of randn function from numpy, uses the built in gaussian distribution from the java random class.
     *
     * @param rows How many rows the array should have.
     * @param cols How many columns the array should have.
     * @return The newly created gaussian distributed array.
     */
    public double[][] randn(int rows, int cols) {
        double[][] output = new double[rows][cols];
        for (int i = 0; i < output.length; i++) {
            for (int j = 0; j < output[0].length; j++) {
                output[i][j] = 0.1 * random.nextGaussian();
            }
        }
        return output;
    }

    /**
     * Updated to calculate the dot product of multidimensional arrays.
     *
     * @param input1 input array 1.
     * @param input2 input array 2
     * @return Newly created dot product of parameter arrays.
     */
    private static double[][] dotProduct(double[][] input1, double[][] input2) {
        double[][] output = new double[input1.length][input2[0].length];
        for (int i = 0; i < output.length; i++) {
            for (int j = 0; j < output[0].length; j++) {
                double value = 0;
                for (int k = 0; k < input1[0].length; k++) {
                    value += input1[i][k] * input2[k][j];
                }
                output[i][j] = value;
            }
        }
        return output;
    }

    /**
     * Updated to add a 2 dimensional array to a one dimensional array.
     *
     * @param input1 Two dimensional array
     * @param input2 One dimensional array.
     * @return Newly created array of sum of parameter arrays.
     */
    private static double[][] add(double[][] input1, double[] input2) {
        double[][] output = new double[input1.length][input1[0].length];
        for (int i = 0; i < input1.length; i++) {
            for (int j = 0; j < input1[0].length; j++) {
                output[i][j] = input1[i][j] + input2[j];
            }
        }
        return output;
    }

}


