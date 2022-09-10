using System.Collections.Generic;
using UnityEngine;
using Random = UnityEngine.Random;

public class Script4 : MonoBehaviour
{
    // Declare Variables
    public float[][] X;
    public List<string> finalOutput;

    // Create Class
    public class LayerDense
    {
        // Declare Class Specific Variables
        float[][] weights = null;
        float[] biases = null;
        public float[][] output = null;
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
                for (int j = 0; j<n_neurons; j++)
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
            output = batchResults.ToArray();
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
                results.Add(Mathf.Round(sum*1000)/1000);
            }
            return results.ToArray();
        }

        // Save outputs to a serialized format to display in inspector.
        public List<string> PostResults()
        {
            foreach (var line in output)
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
    // Start is called before the first frame update
    void Start()
    {
        // Set input values
        X = new float[][]
        {
            new float[] { 1f, 2f, 3f, 2.5f },
            new float[] { 2.0f, 5.0f, -1.0f, 2.0f },
            new float[] { -1.5f, 2.7f, 3.3f, -0.8f }
        };

        // Start with same initial random seed for the same results each time.
        Random.InitState(0);

        // Create layers, pass inputs through layers, and get final Output.
        LayerDense layer1 = new LayerDense(4, 5);
        LayerDense layer2 = new LayerDense(5, 2);
        layer1.Forward(X);
        layer2.Forward(layer1.output);
        finalOutput = layer2.PostResults();
    }
}
