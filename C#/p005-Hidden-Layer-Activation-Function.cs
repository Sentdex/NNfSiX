using Accord.Math;
using System;

namespace NNFS
{
    /// <summary>
    /// Class Definition of Dense_Layer
    /// </summary>
    public class Layer_Dense {
        // Variables to be used in Dense Layer
        double[][] weights = null;
        double[] biases = null;
        public double[][] output = null;

        public Layer_Dense(int n_inputs, int n_neurons)
        {
            // Initializing Double Jagged Array
            weights = new double[n_inputs][];
            // Generating Random Matrix with Accord.Net
            for (int i = 0; i < n_inputs; i++)
            {
                weights[i] = Vector.Random(n_neurons);
            }
            // Initializing Biases with Zero
            biases = new double[n_neurons];
            for(int i = 0; i < n_neurons; i++)
            {
                biases[i] = 0;
            }
        }

        public void Forward(double[][] inputs)
        {
            // Calculating Dot Product using Accord.Net Math
            output = Matrix.Dot(inputs, weights);

            // Adding Biases to Each output
            for (int i = 0; i < output.Length; i++)
            {
                for (int j = 0; j < output[i].Length; j++)
                {
                    output[i][j] = Math.Round(output[i][j] + biases[j], 2);
                }
            }
        }
    }

    /// <summary>
    /// Class definition for Rectified Linear Activation Function
    /// </summary>
    class Activation_ReLU
    {
        // Output variable after Activation is applied
        public double[][] output = null;
        public double[][] Forward(double[][] input)
        {
            // Setting output with the same shape as Input
            output = new double[input.Length][];
            // Checking Maximum values and return max
            for (int i = 0; i < input.Length; i++)
            {
                output[i] = new double[input[i].Length];
                for (int j = 0; j < input[i].Length; j++)
                {
                    output[i][j] = input[i][j] > 0 ? input[i][j] : 0;
                }
            }

            return output;
        }
    }
    /// <summary>
    /// Neural Network Class Layer definition, Batches and use Layers with Objects.
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            // Inputs
            double[][] X = {
                new double[] { 1, 2, 3, 2.5 },
                new double[] { 2, 5, -1, 2 },
                new double[] { -1.5, 2.7, 3.3, -0.8 }
            };

            // Defining Two Dense Layers
            Layer_Dense layer1 = new Layer_Dense(4, 5);

            // Passing Input Data Through the Layers
            layer1.Forward(X);
            // Initiation Activation Function Class
            Activation_ReLU activation = new Activation_ReLU();
            // Passing Layer 1 Ouput as input to Activation Function
            double[][] activation_output = activation.Forward(layer1.output);

            // Displaying Activation Function Output as Matrix in Console
            DisplayOutput(layer2.output);

            Console.Read();
        }

        // Method to Display Jagged Array as Matrix in Console
        static void DisplayOutput(double[][] array)
        {
            for (int i = 0; i < array.Length; i++)
            {
                string output_string = "[";
                for (int j = 0; j < (array[i]).Length; j++)
                    output_string += array[i][j] + " ,";
                output_string = output_string.TrimEnd(',');
                output_string += "]";

                Console.WriteLine(output_string);
            }
        }
    }
}