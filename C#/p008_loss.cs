/*
 * P.8 Categorical Entropy Loss Concept, just to demonstrate how to calculate loss using
 * categorical cross entropy in the case of using scalar class values or 1-hot encoded matrix
 * Based on nnfs.io by Harrison Kinsley & Daniel Kukiela
 * p008 from YT tutorial for the book: https://youtu.be/levekYbxauw
 * spiral dataset code based on: https://gist.github.com/Sentdex/454cb20ec5acf0e76ee8ab8448e6266c
 * spiral dataset here defined as a class that generates a matrix X and vector y
 * Contributed by T. Marin
 * 
 * Uses MathNet Numerics v4.15 by C.Ruegg, M. Cuda and J. Van Gael for vectors and matrix functions. 
 * To install in MSVS select Menu Project/Mangage NuGet packages...
 * in Browse tab search for MathNet.Numerics and install core package
*/

using System;
using System.Linq;
using MathNet.Numerics.LinearAlgebra;

namespace NNFS_p008_loss
{
    class p008_loss
    {
        static void Main(string[] args)
        {
            //creats shortcuts to Matrix and Vector builders: 
            var M = Matrix<double>.Build;
            var V = Vector<double>.Build;

            var softmax_output = M.DenseOfArray(new double[,] { { 0.7, 0.1, 0.2 },
                                                                { 0.1, 0.5, 0.4 },
                                                                { 0.02, 0.9, 0.08 }});
            var class_targets = V.DenseOfArray(new double[] { 0, 1, 1 });

            Console.WriteLine(softmax_output.ToString());
            Console.WriteLine(class_targets.ToString());

            //Creates a vector with the correct outputs based on a index vector of class targets:
            var correct_output = V.Dense(class_targets.Count);
            for (int i = 0; i < class_targets.Count; i++)
            {
                var column = softmax_output.Column(Convert.ToInt16(class_targets[i]));
                var value = column[i];
                correct_output[i] = value;
            }
            Console.WriteLine("\nCorrect Outputs:");
            Console.WriteLine(correct_output.ToString());

            //Clip values
            p008_loss p008 = new p008_loss();
            correct_output = p008.clip_V(correct_output, 1e-7, (1 - 1e-7));
            Console.WriteLine("\nClipped Outputs:");
            Console.WriteLine(correct_output.ToString());
            //calculate loss
            var neg_loss = -correct_output.PointwiseLog();
            Console.WriteLine($"Negative loss vector: {neg_loss.ToString()}");
            var average_loss = neg_loss.Average();
            Console.WriteLine($"Average loss: {average_loss}");


            //Case where the class targets are given with the 1-hot encoded value:
            var class_target_1hot = M.DenseOfArray(new double[,] { { 1, 0, 0},
                                                                   { 0, 1, 0 },
                                                                    {0, 1, 0 }});
            Console.WriteLine("\nCase of using 1-hot encoded class targets");
            Console.WriteLine(softmax_output.ToString());
            Console.WriteLine(class_target_1hot.ToString());
            correct_output = softmax_output.PointwiseMultiply(class_target_1hot).RowSums();
            Console.WriteLine(correct_output.ToString());
            correct_output = p008.clip_V(correct_output, 1e-7, (1 - 1e-7));
            Console.WriteLine("\nClipped Outputs:");
            Console.WriteLine(correct_output.ToString());
            //calculate loss
            neg_loss = -correct_output.PointwiseLog();
            Console.WriteLine($"Negative loss vector: {neg_loss.ToString()}");
            average_loss = neg_loss.Average();
            Console.WriteLine($"Average loss: {average_loss}");

            Console.ReadLine();
        }

        Vector<double> clip_V(Vector<double> Vector, double low, double max)
        {
            //var V = Vector<double>.Build;
            for (int i = 0; i < Vector.Count; i++)
            {
                if (Vector[i] == 0)
                {
                    Vector[i] = low;
                }
                else if (Vector[i] == 1)
                {
                    Vector[i] = max;
                }
            }
            var V_out = Vector;
            return V_out;

        }
    }
}
