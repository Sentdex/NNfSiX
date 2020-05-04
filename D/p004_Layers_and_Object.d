/*
Associated YT NNFS tutorial: https://youtu.be/TEWy9vZcxW4

>>> time rdmd p004.d
Output:
[
  [0.131433, 0.1735]
  [0.142335, 0.187946]
  [0.0592374, 0.0767831]
]

real    0m0.024s
user    0m0.018s
sys 0m0.012s
*/

import std.stdio: writeln, write;
import std.algorithm: equal;
import std.math : approxEqual;
import std.conv: to;
import std.numeric : dotProduct;
import std.random;
import std.array;


void main()
{
    double[][] inputs = [
        [1.0, 2.0, 3.0, 2.5],
        [2.0, 5.0, -1.0, 2.0],
        [-1.5, 2.7, 3.3, -0.8]
    ];

    Layer_Dense layer1 = new Layer_Dense(4, 5);
    layer1.forward(inputs);

    Layer_Dense layer2 = new Layer_Dense(5, 2);
    layer2.forward(layer1.output);
    print(layer2.output);
}


class Layer_Dense
{
    double[][] weights;
    double[] biases;
    double[][] output;

    this(int n_inputs, int n_neurons)
    {
        this.weights = randn(n_inputs, n_neurons);
        foreach(i; 0 .. n_neurons)
            this.biases ~= 0;
    }

    void forward(double[][] inputs)
    {
        this.output = inputs.dotProduct(this.weights).transpose;
        this.output = this.output.add(biases);
    }
}


// specifically tests the same neurons used in the python example
unittest
{
    Layer_Dense layer1 = new Layer_Dense(4, 5);
    layer1.weights = [
        [ 0.17640523,  0.04001572,  0.0978738,   0.22408932,  0.1867558 ],
        [-0.09772779,  0.09500884, -0.01513572, -0.01032189,  0.04105985],
        [ 0.01440436,  0.14542735,  0.07610377,  0.0121675,   0.04438632],
        [ 0.03336743,  0.14940791, -0.02051583,  0.03130677, -0.08540957]
    ];

    double[][] inputs = [
        [1.0, 2.0, 3.0, 2.5],
        [2.0, 5.0, -1.0, 2.0],
        [-1.5, 2.7, 3.3, -0.8]
    ];

    double[][] layer1_output = [
        [ 0.10758131,  1.03983522,  0.24462411,  0.31821498,  0.18851053],
        [-0.08349796,  0.70846411,  0.00293357,  0.44701525,  0.36360538],
        [-0.50763245,  0.55688422,  0.07987797, -0.34889573,  0.04553042]
    ];

    layer1.forward(inputs);
    assert(equal!approxEqual(layer1_output, layer1.output));

    Layer_Dense layer2 = new Layer_Dense(5, 2);
    layer2.weights = [
        [-0.25529898,  0.06536186],
        [ 0.08644362, -0.0742165 ],
        [ 0.22697546, -0.14543657],
        [ 0.00457585, -0.01871839],
        [ 0.15327792,  0.14693588]
    ];

    double[][] layer2_output = [
        [ 0.148296,   -0.08397602],
        [ 0.14100315, -0.01340469],
        [ 0.20124979, -0.07290616]
    ];

    layer2.forward(layer1.output);

    assert(equal!approxEqual(layer2_output, layer2.output));
}


double[][] dotProduct(double[][] weights, double[][] inputs)
{
    //double-check that the two matrices have dimensions we can work with
    assert(inputs.length == weights[0].length);

    double[][] output;
    //transpose the inputs array, so that we can just iterate through it row-by-row
    //probably more computationally expensive to do it this way, but still fast at this point
    foreach (row; inputs.transpose)
        output ~= weights.dotProduct(row);

    return output;
}


unittest
{
    double[][] weights = [
        [0.2, 0.8, -0.5, 1], 
        [0.5, -0.91, 0.26, -0.5], 
        [-0.26, -0.27, 0.17, 0.87]
    ];

    double[][] inputs = [
        [1, 2, 3, 2.5],
        [2., 5., -1., 2],
        [-1.5, 2.7, 3.3, -0.8]
    ];

    double[][] output = [
        [ 2.8  , -1.79 ,  1.885],
        [ 6.9  , -4.81 , -0.3  ],
        [-0.59 , -1.949, -0.474]
    ];

    assert(weights.dotProduct(inputs.transpose) == output);
}


// dot product for an output of only one row
double[] dotProduct(double[][] weights, double[] inputs)
{
    double[] output;
    foreach (weight; weights)
    {
        output ~= dotProduct(weight, inputs);
    }

    return output;
}


unittest
{
    double[][] weights = [
        [1, 2, 3], 
        [4, 5, 6]
    ];

    double[] inputs = [1, 2, 3];
    double[] output = [14  , 32];

    assert(weights.dotProduct(inputs) == output);
}


//matrix addition
double[][] add(double[][] matrix, double[] biases)
{
    assert(to!int(matrix[0].length) == to!int(biases.length));

    for (int i; i < matrix.length; ++i)
        for (int j; j < matrix[i].length; ++j)
            matrix[i][j] += biases[j];

    return matrix;
}


// test that add works the way we intend
unittest
{
    double[][] in_one = [[1, 2], [3, 4]];
    double[] in_two = [5, 6];
    double[][] output = [[6, 7], [9, 10]];

    assert (equal(in_one.add(in_two), output));
}

// transposition function
double[][] transpose(double[][] matrix)
{
    // create a new matrix that we can assign to without affecting the original matrix in memory
    double[][] output;
    output.length = matrix[0].length;

    for (int i ; i < matrix.length; ++i)
        for (int j ; j < matrix[0].length; ++j)
        {
            output[j] ~= matrix[i][j];
        }

    return output;
}

//test that transpose works the way we want it to
unittest
{
    double[][] input = [[1, 2], [3, 4]];
    double[][] output = [[1, 3], [2, 4]];

    assert (equal(input.transpose, output));
}


double[][] randn(int n_inputs, int n_neurons)
{
    auto rnd = Random(0);
    double[][] output;
    output.length = n_inputs;
    for (int i; i < n_inputs; ++i)
    {
        for (int j; j < n_neurons; ++j)
        {
            auto b = uniform!"[]"(0.0f, 1.0f, rnd);
            output[i] ~= 0.1 * to!double(b);
        }
    }

    return output;
}


void print(double[][] matrix)
{
    writeln("[");
    foreach (row; matrix)
    {
        write("  ");
        writeln(row);
    }

    writeln("]");
}
