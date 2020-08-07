/*
 * Credit to vancegillies for the spiral dataset generator, I found his method of generating a spiral dataset in
 * javascript easy to replicate in java.(original spiral dataset pull request
 * by vancegillies: https://github.com/Sentdex/NNfSiX/pull/128/commits/c0ec61a1032c6d9f783b7e731115ae0aa8aed9fd )
 *
 * Relu activation function and spiral data generator.
 *
 * Associated tutorial: https://www.youtube.com/watch?v=gmjzbpSVY1A&t=1840s
 */

import java.util.Arrays;
import java.util.Random;

public class P005ReLUActivationAndSpiralDataset {
    private static final Random random = new Random(0);

    /**
     * Main method, establishes data to be used, creates two layers and runs data through both layers to get output.
     */
    public static void main(String[] args) {
        //create a dataset object to hold features
        Dataset dataset = new Dataset();
        dataset.create_data(100, 3);

        Layer_Dense layer1 = new Layer_Dense(4, 5);
        Activation_ReLU activation1 = new Activation_ReLU();

        layer1.forward(dataset.X);
        activation1.forward(layer1.output);
        System.out.println(Arrays.deepToString(activation1.output));
    }

    private static class Dataset {
        private double[][] X;
        private int[] Y;

        public void create_data(int points, int classes) {
            X = new double[points * classes][2];
            Y = new int[points * classes];
            int ix = 0;
            for (int class_number = 0; class_number < classes; class_number++) {
                double r = 0;
                double t = class_number * 4;
                while (r <= 1 && t <= (class_number + 1) * 4) {
                    double random_t = t + random.nextInt(points) * 0.2;
                    X[ix][0] = r * Math.sin(random_t * 2.5);
                    X[ix][1] = r * Math.cos(random_t * 2.5);
                    Y[ix] = class_number;
                    r += 1.0 / (points - 1);
                    t += 4.0 / (points - 1);
                    ix++;
                }
            }
        }
    }

    private static class Layer_Dense {
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

    private static class Activation_ReLU {
        private double[][] output;
        /**
         * Feed forward method used to calculate ReLU output of layer.
         *
         * @param inputs Input to be used to calculate output.
         */
        public void forward(double[][] inputs) {
            output = new double[inputs.length][inputs[0].length];
            for (int i = 0; i < output.length; i++) {
                for (int j = 0; j < output[0].length; j++) {
                    if (inputs[i][j] > 0) {
                        output[i][j] = 0;
                    } else {
                        output[i][j] = inputs[i][j];
                    }
                }
            }
        }
    }
}



