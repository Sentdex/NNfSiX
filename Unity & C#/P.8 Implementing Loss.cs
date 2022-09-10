using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using Random = UnityEngine.Random;

public class Script8 : MonoBehaviour
{
    // Declare Variables
    public float[][] X;
    [HideInInspector] public int[][] y;
    public List<string> finalOutput;
    public LayerDense layer1;
    public LayerDense layer2;
    public Activation_Relu activation1 = new Activation_Relu();
    public Activation_Softmax activation2 = new Activation_Softmax();
    public Loss_CategoricalCrossEntropy lossFunction = new Loss_CategoricalCrossEntropy();
    public float averageLoss;
    public float[] individualLosses;

    // Declare Variables for Data Creation
    [HideInInspector] public int points = 100;
    [HideInInspector] public int classes = 3;
    [HideInInspector] public bool dataReady = false;
    // These are prefabs of objects made to mark out the positions for the various classes in the spiral, coloured circles.
    public GameObject class1;
    public GameObject class2;
    public GameObject class3;
    // Game Object to act as parent for the above prefabs, should be child of canvas
    public GameObject parent;

    // Create Class for layers
    public class LayerDense
    {
        // Declare Class Specific Variables
        float[][] weights = null;
        float[] biases = null;
        public float[][] outputs = null;
        public List<float[]> batchResults = new List<float[]>();
        public List<float> results = new List<float>();
        public List<string> outputsPrinted = new List<string>();

        // Class Constructor. Wasn't able to figure out how to convert the np.random.randn so I just
        // created something that gives results consistent with what they are looking for in the video.
        public LayerDense(int n_inputs, int n_neurons)
        {
            // Initialize the weights to random numbers from -.3 to .3
            weights = new float[n_inputs][];
            for (int i = 0; i < n_inputs; i++)
            {
                weights[i] = new float[n_neurons];
                for (int j = 0; j < n_neurons; j++)
                {
                    weights[i][j] = Random.Range(-.3f, .3f);
                }
            }

            // Initialize the biases to 0
            biases = new float[n_neurons];
            for (int i = 0; i < n_neurons; i++) biases[i] = 0;
        }

        // Forward Method
        public void Forward(float[][] inputs)
        {
            // Start with an empty list.
            batchResults.Clear();

            // Calculate the outputs for each batch of inputs, and add to list
            for (int i = 0; i < inputs.Length; i++)
            {
                batchResults.Add(LayerResults(inputs[i], weights, biases));
            }

            // Save outputs from the batch results.
            outputs = batchResults.ToArray();
        }

        // Calculate the Dot Product and add the bias for a single input batch.
        public float[] LayerResults(float[] layerInputs, float[][] layerWeights, float[] layerBiases)
        {
            results.Clear();
            for (int i = 0; i < layerWeights[0].Length; i++)
            {
                float sum = 0;
                for (int j = 0; j < layerInputs.Length; j++)
                {
                    sum += layerInputs[j] * layerWeights[j][i];
                }
                sum += layerBiases[i];
                results.Add(Mathf.Round(sum * 1000000) / 1000000);
            }
            return results.ToArray();
        }

        // Save outputs to a serialized format to display in inspector.
        public List<string> PostResults()
        {
            foreach (var line in outputs)
            {
                string outputString = "[";
                for (int n = 0; n < line.Length; n++)
                {
                    outputString += line[n].ToString() + ", ";
                }
                outputString = outputString.TrimEnd(' ');
                outputString = outputString.TrimEnd(',');
                outputString += "]";
                outputsPrinted.Add(outputString);
            }
            return outputsPrinted;
        }
    }
    // Create ReLU object
    public class Activation_Relu
    {
        public float[][] outputs;
        public void Forward(float[][] inputs)
        {
            outputs = new float[inputs.Length][];
            for (int i = 0; i < inputs.Length; i++)
            {
                outputs[i] = new float[inputs[i].Length];
                for (int i2 = 0; i2 < inputs[i].Length; i2++)
                {
                    outputs[i][i2] = Mathf.Max(0, inputs[i][i2]);
                }

            }
        }
    }
    // Create Softmax object
    public class Activation_Softmax
    {
        public float[][] outputs;
        public void Forward(float[][] inputs)
        {
            outputs = new float[inputs.Length][];
            float[][] exp_values = new float[inputs.Length][];
            float[][] probabilities = new float[inputs.Length][];
            for (int i = 0; i < inputs.Length; i++)
            {
                exp_values[i] = new float[inputs[i].Length];
                probabilities[i] = new float[inputs[i].Length];
                float maxValue = Mathf.Max(inputs[i]);
                for (int i2 = 0; i2 < inputs[i].Length; i2++)
                {
                    exp_values[i][i2] = Mathf.Exp(inputs[i][i2] - maxValue);
                }
                for (int i2 = 0; i2 < inputs[i].Length; i2++)
                {
                    probabilities[i][i2] = exp_values[i][i2] / exp_values[i].Sum();
                }
            }
            outputs = probabilities;
        }
    }
    // Create Loss class
    public class Loss
    {
        public float[] sample_losses;
        public float data_loss;

        // In order to deal with both types of data sets listed in the video, you must pass both types of int arrays.
        // The data created by the Create Data script is in the One Hot Encoded format, so when passing the int[]
        // for y_true_single, simply pass new int[1], or if you're using a 1D array of data, then you'll
        // pass new int[1][] for the y_true_ohe parameter. Virtual exists only to be overridden by individual loss functions Forward method.
        public virtual float[] Forward(float[][] output, int[] y_true_single, int[][] y_true_ohe)
        {
            return new float[1];
        }

        // Calculate method. I made it return the batch data loss, but as both variables are public, you can access
        // either once they are calculated
        public float Calculate(float[][] output, int[] y, int[][]y_ohe)
        {
            sample_losses = Forward(output, y, y_ohe);
            data_loss = sample_losses.Average();
            return data_loss;
        }
    }

    // CCE Loss class, using loops to replace the convenience of numpy
    public class Loss_CategoricalCrossEntropy : Loss
    {
        // This method overrides the Forward of the base Loss class.
        public override float[] Forward(float[][] y_pred, int[] y_true_single, int[][] y_true_ohe)
        {
            // Declare internal variables
            int samples = y_pred.Length;
            float[][] y_pred_clamped = new float[samples][];
            float[] correctConfidences = new float[samples];
            float[] negativeLogLikelihoods = new float[samples];

            // Get Clamped predictions
            for (int i = 0; i < samples; i++)
            {
                y_pred_clamped[i] = new float[y_pred[i].Length];
                for (int j = 0; j < y_pred[i].Length; j++)
                    y_pred_clamped[i][j] = Mathf.Clamp(y_pred[i][j], 1e-7f, 1 - 1e-7f);
            }

            // Get correct confidences, depending on which type of y_true data matches the length of samples.
            if (y_true_single.Length == samples)
            {
                for(int i = 0; i < samples; i++)
                {
                    correctConfidences[i] = y_pred_clamped[i][y_true_single[i]];
                }
            }
            else if (y_true_ohe.Length == samples)
            {
                for (int i = 0; i < samples; i++)
                {
                    correctConfidences[i] = y_pred_clamped[i][y_true_ohe[i][Array.IndexOf(y_true_ohe[i], 1)]];
                }
            }

            // Get the negative log likelihoods
            for (int i = 0; i < samples; i++)
            {
                negativeLogLikelihoods[i] = -Mathf.Log(correctConfidences[i]);
            }
            return negativeLogLikelihoods;
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        // Get Data Reference
        CreateData();

        // Start with same initial random seed for the same results each time.
        Random.InitState(0);

        // Create layers, pass inputs through layers, and get final Output.
        layer1 = new LayerDense(2, 3);
        layer2 = new LayerDense(3, 3);
    }

    // Update is called once per frame
    void Update()
    {
        if (dataReady)
        {
            // Pass inputs through the layers of neurons
            layer1.Forward(X);
            activation1.Forward(layer1.outputs);
            layer2.Forward(activation1.outputs);
            activation2.Forward(layer2.outputs);
            layer2.outputs = activation2.outputs;
            finalOutput = layer2.PostResults();

    // Calculate Losses, viewable in the inspector
    // You must pass new int[1] as the 2nd param if you're using a One Hot Encoded Data set
    // You must pass new int[1][] as the 3rd param if your data set is 1 dimensional.
            averageLoss = lossFunction.Calculate(layer2.outputs, new int[1], y);
            individualLosses = lossFunction.sample_losses;
            dataReady = false;
        }

    }
    public void CreateData()
    {
        // Setup Variables
        X = new float[points * classes][];
        y = new int[points * classes][];

        // Loop to Create 100 of each class of data
        for (int i = 1; i < classes + 1; i++)
        {
            var r = Linspace(0, 1, points + 1);
            var c = Linspace(i * 4, (i + 1) * 4, points);
            var t = c.Select((c, index) => c + Random.Range(-0.5f, 0.5f)).ToArray();
            // Assign classes to data in the One Hot Encoded format
            for (int index = 0; index < points; index++)
            {
                X[index + ((i - 1) * 100)] = new float[] { r[index + 1] * Mathf.Sin((float)t[index] * 2.5f), r[index + 1] * Mathf.Cos((float)t[index] * 2.5f) };
                switch (i)
                {
                    case 1:
                        y[index + ((i - 1) * 100)] = new int[] { 1, 0, 0 };
                        break;
                    case 2:
                        y[index + ((i - 1) * 100)] = new int[] { 0, 1, 0 };
                        break;
                    case 3:
                        y[index + ((i - 1) * 100)] = new int[] { 0, 0, 1 };
                        break;
                    default:
                        y[index + ((i - 1) * 100)] = new int[] { 0, 0, 0 };
                        break;
                }
            }
        }

        // Instantiate Prefab Objects to mark out spirals
        for (int i = 0; i < X.Length; i++)
        {
            Vector3 position = new Vector3(X[i][0], X[i][1], 0);
            if (y[i][0] == 1)
                Instantiate(class1, new Vector3(X[i][0], X[i][1], 0), class1.transform.rotation, parent.transform);
            else if (y[i][1] == 1)
                Instantiate(class2, new Vector3(X[i][0], X[i][1], 0), class2.transform.rotation, parent.transform);
            else
                Instantiate(class3, new Vector3(X[i][0], X[i][1], 0), class3.transform.rotation, parent.transform);
        }
        dataReady = true;
    }
    // Custom function to match np.linspace
    static float[] Linspace(float StartValue, float EndValue, int numberofpoints)
    {
        float[] parameterVals = new float[numberofpoints];
        float increment = Math.Abs(StartValue - EndValue) / (numberofpoints - 1);
        int j = 0; //will keep a track of the numbers 
        float nextValue = StartValue;
        for (int i = 0; i < numberofpoints; i++)
        {
            parameterVals.SetValue(nextValue, j);
            j++;
            if (j > numberofpoints)
            {
                throw new IndexOutOfRangeException();
            }
            nextValue += increment;
        }
        return parameterVals;
    }
}

