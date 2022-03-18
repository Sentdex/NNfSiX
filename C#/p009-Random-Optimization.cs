/*
 * Class Definition of P.9 Introduction to Optimization. Use random search to minimize loss
 * Based on nnfs.io by Harrison Kinsley & Daniel Kukiela
 * p008 from YT tutorial for the book: https://youtu.be/txh3TQDwP1g
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
using MathNet.Numerics;
using MathNet.Numerics.LinearAlgebra;

namespace NNFS_p009
{
    class p009
    {
        static void Main(string[] args)
        {
            var M = Matrix<double>.Build;

            // Create dataset
            spiral_data spiral_data = new spiral_data(100, 3);
            Matrix<double> X = spiral_data.X;
            Vector<double> y = spiral_data.y;
            Console.WriteLine($"X spiral data:{X.ToString()}");
            Console.WriteLine($"y spiral data class def vector:{y.ToString()}");

            // Create model
            Layer_Dense dense1 = new Layer_Dense(2, 3); //2 inputs, 3 neurons
            Activation_ReLU activation1 = new Activation_ReLU();
            Layer_Dense dense2 = new Layer_Dense(3, 3); //3 inputs, 3 neurons
            Activation_Softmax activation2 = new Activation_Softmax();

            // Create loss function
            Loss_CategoricalCrossentropy loss_function = new Loss_CategoricalCrossentropy();

            // Helper variables
            double lowest_loss = 9999999; //initial value
            var best_dense1_weights = dense1.weights;
            var best_dense1_biases = dense1.biases;
            var best_dense2_weights = dense2.weights;
            var best_dense2_biases = dense2.biases;



            for (int i = 0; i < 10000; i++)
            {
                // Update weights with some small random values
                dense1.weights += 0.05 * M.Random(dense1.weights.RowCount, dense1.weights.ColumnCount);
                dense1.biases += 0.05 * M.Random(1, dense1.biases.ColumnCount);
                dense2.weights += 0.05 * M.Random(dense2.weights.RowCount, dense2.weights.ColumnCount);
                dense2.biases += 0.05 * M.Random(1, dense2.biases.ColumnCount);

                // Perform a forward pass of our training data through data through this layer
                dense1.forward(X);
                activation1.forward(dense1.output);
                dense2.forward(activation1.output);
                activation2.forward(dense2.output);

                // Perform a forward pass through activation function
                // it takes the output of second dense layer here and returns loss
                var loss = loss_function.Calculate(activation2.output, y);

                //calculate accuracy from output of activation2 and targets
                var accuracy = loss_function.accuracy;

                // If loss is smaller - print and save weights and biases aside
                if (loss < lowest_loss)
                {
                    Console.WriteLine($"New set of weights found, iteration: {i}, loss: {loss}, acc: {accuracy}");
                    best_dense1_weights = dense1.weights;
                    best_dense1_biases = dense1.biases;
                    best_dense2_weights = dense2.weights;
                    best_dense2_biases = dense2.biases;
                    lowest_loss = loss;
                }
                else
                {
                    dense1.weights = best_dense1_weights;
                    dense1.biases = best_dense1_biases;
                    dense2.weights = best_dense2_weights;
                    dense2.biases = best_dense2_biases;
                }
            }

            Console.WriteLine("\nOptimized neural network:");
            Console.WriteLine($"dense 1 weights: {dense1.weights.ToString()}");
            Console.WriteLine($"dense 1 bias: {dense1.biases.ToString()}");
            Console.WriteLine($"dense 2 weights: {dense2.weights.ToString()}");
            Console.WriteLine($"dense 2 weights: {dense1.biases.ToString()}");

            Console.WriteLine($"Output: {activation2.output}");
            Console.WriteLine($"\nPredictions: {loss_function.final_predictions.ToString()}");

            Console.ReadLine();
        }
    }

    // Spiral data class
    public class spiral_data
    {
        //attributes
        public Matrix<double> X; // matrix storing the data x,y coordinates of the spiral
        public Vector<double> y; // vector storing the label for each class

        //constuctor
        public spiral_data(int samples, int classes)
        {
            //creats shortcuts to Matrix and Vector builders: 
            var M = Matrix<double>.Build;
            var V = Vector<double>.Build;
            //build vectors of size points*classesx1 for y, r and theta
            y = V.Dense(samples * classes); //at this point this is full of zeros
            for (int j = 0; j < classes; j++)
            {
                var y_step = V.DenseOfArray(Generate.Step(samples * classes, 1, (j + 1) * samples));
                y = y + y_step;
            }
            var r = V.DenseOfArray(Generate.Sawtooth(samples * classes, samples, 0, 1));
            var theta = 4 * (r + y) + (2 * V.DenseOfArray(Generate.Standard(samples * classes)) * 0.2);
            var sin_theta = theta.PointwiseSin();
            var cos_theta = theta.PointwiseCos();

            X = M.DenseOfColumnVectors(r.PointwiseMultiply(sin_theta), r.PointwiseMultiply(cos_theta));
        }
    }

    // Define Dense layer class
    public class Layer_Dense
    {
        //attributes
        public Matrix<double> weights; //make them public attributs to be visible at program level
        public Matrix<double> biases;   //define as "horizontal" vector or 1xn matrix
        public Matrix<double> output;   //matrix with outputs

        //constructor
        public Layer_Dense(int n_inputs, int n_neurons)
        {
            //creats shortcuts to Matrix and Vector builders: 
            var M = Matrix<double>.Build;
            var V = Vector<double>.Build;

            //creates a n_inputs x n_neurons random matrix and assign to weights
            weights = M.Random(n_inputs, n_neurons);

            //creates a zero filled vector, this has to be a horizontal vector, hense using a 1xn matrix
            biases = M.Dense(1, n_neurons);
        }

        //Forward function
        public void forward(Matrix<double> inputs)
        {
            //creates a Matrix of size: (batches x 1) , this is just an aux "vector"
            var M = Matrix<double>.Build;
            var v = M.Dense(inputs.RowCount, 1, 1);
            //multiply matrix v*biases: (batches x 1) dot (1 x neurons) = (batches x neurons) where each row is the same as the horizontal biases vector
            var biasm = v * biases; //biasm is a matrix where each row is identical and the rows are the biases horizontal vector
            //now bias matrix can be added to inputs*weights
            output = inputs * weights + biasm;
        }
    }

    // ReLU Activation Class
    public class Activation_ReLU
    {
        //attributes
        public Matrix<double> output;   //matrix with outputs

        //Forward function
        public void forward(Matrix<double> inputs)
        {
            output = inputs.PointwiseMaximum(0);
        }
    }

    //Define Softmax Activation Class
    public class Activation_Softmax
    {
        //attributes
        public Matrix<double> output; //matrix with outputs

        //Forward function
        public void forward(Matrix<double> inputs)
        {
            //Get max value of each sample and shift sample to zero
            for (int i = 0; i < inputs.RowCount; i++)
            {
                var e_V = inputs.Row(i);
                var max_row = e_V.Maximum();
                e_V = e_V.Subtract(max_row);
                inputs.SetRow(i, e_V);
            }
            //Get unnormalized probabilities
            var exp_values = inputs.PointwiseExp();
            //Normalize them for each sample
            var probabilites = exp_values.NormalizeRows(1.0); //uses L1 norm which is the same as each element / sum of elements for each row
            output = probabilites;
        }
    }

    //Define Loss General function
    public class Loss
    {
        //attributes
        public Vector<double> sample_losses { get; set; }
        public double data_loss { get; set; }
        public double accuracy { get; set; }
        public Vector<double> final_predictions { get; set; }
        //Getter and setters:

        //Methods:
        //Calculates the data and regularization losses
        //given model output and ground truth values
        //Two "Calculate" and "forward" methods (overrides) are define to differentiate the case of providing
        //class categories as scalar vector or as a 1-hot encoded matrix
        public double Calculate(Matrix<double> output, Vector<double> y)
        {
            //Calculates and return data loss:
            var V = Vector<double>.Build;
            var data_loss_vector = forward(output, y);
            data_loss = data_loss_vector.Average();

            //Calculate accuracy:
            //Creates a vector with the positions of the predicitions for each row in softmax_output (argmax axis=1)
            var preditions = V.Dense(output.RowCount);
            var compare = V.Dense(output.RowCount, 0);
            for (int i = 0; i < output.RowCount; i++)
            {
                preditions[i] = output.Row(i).MaximumIndex(); //this is equivalent to argmax in a single row
                if (preditions[i] == y[i])
                {
                    compare[i] = 1;
                }
            }
            accuracy = compare.Average();
            final_predictions = preditions;
            return data_loss;
        }
        public double Calculate(Matrix<double> output, Matrix<double> y)
        {
            //Calculates and return data loss:
            var V = Vector<double>.Build;
            var data_loss_vector = forward(output, y);
            data_loss = data_loss_vector.Average();
            //Calculate accuracy:
            //Creates a vector with the positions of the predicitions for each row in softmax_output (argmax axis=1)
            var preditions = V.Dense(output.RowCount);
            var compare = V.Dense(output.RowCount, 0);
            for (int i = 0; i < output.RowCount; i++)
            {
                preditions[i] = output.Row(i).MaximumIndex();
                if (preditions[i] == y.Row(i).MaximumIndex())
                {
                    compare[i] = 1;
                }
            }
            accuracy = compare.Average();
            final_predictions = preditions;
            return data_loss;
        }

        //forward methods here are placeholders only and are overriden in the descendant class
        //first version of the method is to handle the case of a scalar values
        public virtual Vector<double> forward(Matrix<double> y_pred, Vector<double> y)
        {
            //to be overriden in descentant classes
            return y;
        }
        //second version of the method is to handle the case of 1-hot encoded matrix
        public virtual Vector<double> forward(Matrix<double> y_pred, Matrix<double> y)
        {
            //to be overriden in descentant classes, to be used in the case of 1-hot encoded class target
            var V = Vector<double>.Build;
            var V_aux = V.Dense(y_pred.RowCount);
            return V_aux;
        }

    }

    public class Loss_CategoricalCrossentropy : Loss
    {
        public override Vector<double> forward(Matrix<double> y_pred, Vector<double> y)
        {
            //Creates a vector with the correct outputs based on a index vector of class targets:
            var V = Vector<double>.Build;
            var samples = y_pred.RowCount;
            var y_pred_clipped = V.Dense(samples);
            //if y is a vector containing categorical labels
            for (int i = 0; i < samples; i++)
            {
                var column = y_pred.Column(Convert.ToInt16(y[i]));
                var value = column[i];
                y_pred_clipped[i] = value;
            }
            y_pred_clipped = clip(y_pred_clipped, 1e-7, (1 - 1e-7));
            //calculate loss
            var negative_log_likelihoods = -y_pred_clipped.PointwiseLog();
            return negative_log_likelihoods;
        }
        public override Vector<double> forward(Matrix<double> y_pred, Matrix<double> y)
        {
            //Creates a vector with the correct outputs based on a index vector of class targets:
            var V = Vector<double>.Build;
            var samples = y_pred.RowCount;
            var y_pred_clipped = V.Dense(samples);
            y_pred_clipped = y_pred.PointwiseMultiply(y).RowSums();
            y_pred_clipped = clip(y_pred_clipped, 1e-7, (1 - 1e-7));
            //calculate loss
            var negative_log_likelihoods = -y_pred_clipped.PointwiseLog();
            return negative_log_likelihoods;
        }

        public Vector<double> clip(Vector<double> Vector, double low, double max)
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
