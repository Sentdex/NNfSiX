/*
 * P.8 Accuracy Concept, just to demonstrate how to calculate accuracy
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
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MathNet.Numerics.LinearAlgebra;

namespace NNFS_p008_acc
{
    class p008_acc
    {
        static void Main(string[] args)
        {
            //creats shortcuts to Matrix and Vector builders: 
            var M = Matrix<double>.Build;
            var V = Vector<double>.Build;

            var softmax_output = M.DenseOfArray(new double[,] { { 0.7, 0.1, 0.2 },
                                                                { 0.5, 0.1, 0.4 },
                                                                { 0.02, 0.9, 0.08 }});
            var class_targets = V.DenseOfArray(new double[] { 0, 1, 1 });

            Console.WriteLine(softmax_output.ToString());
            Console.WriteLine(class_targets.ToString());

            //Creates a vector with the positions of the predicitions for each row in softmax_output (argmax axis=1)
            var preditions = V.Dense(softmax_output.RowCount);
            var compare = V.Dense(softmax_output.RowCount, 0);
            for (int i = 0; i < softmax_output.RowCount; i++)
            {
                preditions[i] = softmax_output.Row(i).MaximumIndex();
                if (preditions[i] == class_targets[i])
                {
                    compare[i] = 1;
                }
            }
            Console.WriteLine($"predictions: {preditions.ToString()}");

            Console.WriteLine($"compare: {compare.ToString()}");

            var accuracy = compare.Average();

            Console.WriteLine($"acc: {accuracy}");

            //////////////////////////////////////////////////////////////////////
            //Case where the class targets are given with the 1-hot encoded value:
            var class_target_1hot = M.DenseOfArray(new double[,] { { 1, 0, 0},
                                                                   { 0, 1, 0 },
                                                                    {0, 1, 0 }});
            Console.WriteLine("\nCase of using 1-hot encoded class targets");
            Console.WriteLine("class targets, 1-hpt encoded:");
            Console.WriteLine(class_target_1hot.ToString());
            compare.Clear();
            for (int i = 0; i < class_target_1hot.RowCount; i++)
            {
                preditions[i] = softmax_output.Row(i).MaximumIndex();
                if (preditions[i] == class_target_1hot.Row(i).MaximumIndex())
                {
                    compare[i] = 1;
                }
            }
            Console.WriteLine($"predictions: {preditions.ToString()}");

            Console.WriteLine($"compare: {compare.ToString()}");

            accuracy = compare.Average();
            Console.WriteLine($"acc: {accuracy}");

            Console.ReadLine();
        }
    }
}
