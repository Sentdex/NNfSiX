using Accord.Math;
using System;

namespace NNFS
{
    /// <summary>
    /// Basic Neuron Layer in C#, using Accord.Net Math for Dot Product Calculation
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            double[] inputs = { 1, 2, 3, 2.5 };

            double[][] weights = {
                new double[]{ 0.2, 0.8, -0.5, 1 },
                new double[]{ .5, -0.91, 0.26, -0.5 },
                new double[]{ -0.26, -0.27, 0.17, 0.87 }
            };

            double[] biases = { 2, 3, 0.5 };
            // Calculating Dot Product using Accord.Net Math
            var output = Matrix.Dot(weights, inputs);
            
            // Adding Biases to Each output
            for(int i = 0; i < output.Length; i++)
            {
                output[i] = output[i] + biases[i];
            }

            Console.WriteLine("[" +
                output[0] + "," + output[1] + "," + output[2] +
                "]");
            
            Console.Read();
        }
    }
}