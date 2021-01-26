/*
 * Class Definition of ReLU Activation and spiral dataset
 * Based on nnfs.io by Harrison Kinsley & Daniel Kukiela
 * p005 from YT tutorial for the book: https://youtu.be/gmjzbpSVY1A
 * spiral dataset code based on: https://gist.github.com/Sentdex/454cb20ec5acf0e76ee8ab8448e6266c
 * spiral datase here defined as a function that returns a matrix X
 * 
 * Uses MathNet Numerics v4.11 by C.Ruegg, M. Cuda and J. Van Gael for vectors and matrix functions. 
 * To install in MSVS select Menu Project/Mangage NuGet packages...
 * in Browse tab search for MathNet.Numerics and install core package
*/
using System;
using MathNet.Numerics;
using MathNet.Numerics.LinearAlgebra;

namespace NNFS_p005
{
    class p005
    {
        static void Main(string[] args)
        {
            //in this case, spiral_data is defined as a function within the p005 class, main program.
            //therefore, to access it, it is necessary to first create an instance of p005
            p005 program_p005 = new p005();

            //Inputs, the matrix X is created using spiral_data which is a member of the object program_p005
            Matrix<double> X = program_p005.spiral_data(100, 3);

            //creates one dense layer and one activation layer:
            Layer_Dense layer1 = new Layer_Dense(2, 5); //2 inputs, 5 neurons
            Activation_ReLU activation1 = new Activation_ReLU();

            //call forward function of layer1 using X matrix as inputs
            layer1.Forward(X);

            //call forward function activation1 using outputs from layer 1
            activation1.Forward(layer1.output);

            //print results:
            //Console.WriteLine("\nInput matrix X (spiral data):");
            //Console.WriteLine(X.ToString());

            Console.WriteLine("Forward method layer 1, outputs1:");
            Console.WriteLine(layer1.output.ToString());

            Console.WriteLine("Forward method activation 1 ReLU, outputs1: (100x3) x 5 neurons");
            Console.WriteLine(activation1.output.ToString());

            Console.ReadLine();
        }

        //define dataset
        Matrix<double> spiral_data(int points, int classes)
        {
            //Matrix<double> X;
            //Vector<double> y;
            var M = Matrix<double>.Build; //shortcut to Matrix builder
            var V = Vector<double>.Build; //shortcut to Vector builder

            //build vectors of size points*classesx1 for y, r and theta
            var y = V.Dense(points * classes); //at this point this is full of zeros
            for (int j = 0; j < classes; j++)
            {
                var y_step = V.DenseOfArray(Generate.Step(points * classes, 1, (j + 1) * points));
                y = y + y_step;
            }
            var r = V.DenseOfArray(Generate.Sawtooth(points * classes, points, 0, 1));
            var theta = 4 * (r + y) + (V.DenseOfArray(Generate.Standard(points * classes)) * 0.2);
            var sin_theta = theta.PointwiseSin();
            var cos_theta = theta.PointwiseCos();

            var X = M.DenseOfColumnVectors(r.PointwiseMultiply(sin_theta), r.PointwiseMultiply(cos_theta));
            return X;
        }
    }

    //Define Layer_Dense class
    public class Layer_Dense
    {
        //attributes
        public Matrix<double> weithgts; //make them public attributs to be visible at program level
        public Matrix<double> biases;   //define as "horizontal" vector or 1xn matrix
        public Matrix<double> output;   //matrix with outputs

        //constructor
        public Layer_Dense(int n_inputs, int n_neurons)
        {
            //creats shortcuts to Matrix and Vector builders: 
            var M = Matrix<double>.Build;
            var V = Vector<double>.Build;

            //creates a n_inputs x n_neurons random matrix and assign to weights
            weithgts = M.Random(n_inputs, n_neurons);

            //creates a zero filled vector, this has to be a horizontal vector, hense using a 1xn matrix
            biases = M.Dense(1, n_neurons);
        }

        //Forward function
        public void Forward(Matrix<double> inputs)
        {
            //creates a Matrix of size: (batches x 1) , this is just an aux "vector"
            var M = Matrix<double>.Build;
            var v = M.Dense(inputs.RowCount, 1, 1);
            //multiply matrix v*biases: (batches x 1) dot (1 x neurons) = (batches x neurons) where each row is the same as the horizontal biases vector
            var biasm = v * biases; //biasm is a matrix where each row is identical and the rows are the biases horizontal vector
            //now bias matrix can be added to inputs*weights
            output = inputs * weithgts + biasm;
        }
    }

    //Define ReLU Activation Class
    public class Activation_ReLU
    {
        //attributes
        public Matrix<double> output;   //matrix with outputs

        //Forward function
        public void Forward(Matrix<double> inputs)
        {
            output = inputs.PointwiseMaximum(0);
        }
    }
}
