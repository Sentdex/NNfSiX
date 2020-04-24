/*
Creates a simple layer of neurons, with 4 inputs.
Associated YT NNFS tutorial: https://www.youtube.com/watch?v=tMrbN67U9d4
*/

import std.stdio;
import std.math: exp, tanh, log;
import std.algorithm;
import std.array;


void main()
{
    double[] inputs = [1, 2, 3, 2.5];
    double[] weights1 = [0.2, 0.8, -0.5, 1.0];
    double[] weights2 = [0.5, -0.91, 0.26, -0.5];
    double[] weights3 = [-0.26, -0.27, 0.17, 0.87];

    double[][] combinedWeights = [weights1, weights2, weights3];

    double[] biases = [2, 3, 0.5];

    double[] dot_prod = dotProduct(combinedWeights, inputs);
    double[] output;
    for (int i; i < dot_prod.length; ++i)
        output ~= dot_prod[i] + biases[i];

    writeln(output);
}


double[] dotProduct(double[][] weights, double[] inputs)
{
    double[] output;
    foreach (weight; weights)
    {
        output ~= dotProduct(weight, inputs);
    }

    return output;
}


double dotProduct(double[] weights, double[] inputs)
{
    assert(weights.length == inputs.length);
    double output = 0;
    for (int i; i < inputs.length; ++i)
        output += weights[i] * inputs[i];

    return output;
}
