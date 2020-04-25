using System;

namespace NNFS
{
    /// <summary>
    /// Basic Neuron with 3 Inputs in C#
    /// </summary>
    class Program
    {
        static void Main(string[] args)
        {
            double[] inputs = { 1.2, 5.1, 2.1 };
            double[] weights = { 3.1, 2.1, 8.7 };
            double bias = 3.1;

            double output = inputs[0] * weights[0] + inputs[1] * weights[1] + inputs[2] * weights[2] + bias;
            Console.WriteLine(output);

            Console.Read();
        }
    }
}
