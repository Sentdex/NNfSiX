/*
 * Calculating the loss with Categorical Cross Entropy
 * Based on nnfs.io by Harrison Kinsley & Daniel Kukiela
 * Associated with YT NNFS tutorial: https://www.youtube.com/watch?v=dEXPMQXoiLc
 * Contributed by T. Marin
 * 
 * Uses MathNet Numerics v4.15 by C.Ruegg, M. Cuda and J. Van Gael for vectors and matrix functions. 
 * To install in MSVS select Menu Project/Mangage NuGet packages...
 * in Browse tab search for MathNet.Numerics and install core package
*/

using System;
using MathNet.Numerics.LinearAlgebra;

namespace NNFS_p007
{
    class p007
    {
        static void Main(string[] args)
        {
            //creats shortcuts to Matrix and Vector builders: 
            var M = Matrix<double>.Build;
            var V = Vector<double>.Build;

            var softmax_output = M.DenseOfArray(new double[,] { { 0.7, 0.2, 0.1 } });
            var target_output = V.DenseOfArray(new double[] { 1, 0, 0 });

            var loss = - softmax_output.PointwiseLog() * target_output;

            Console.WriteLine($"{loss.ToString()}");

            Console.WriteLine($"{-Math.Log(0.7)}");

            Console.WriteLine($"{-Math.Log(0.5)}");

            Console.ReadLine();
        }
    }
}
