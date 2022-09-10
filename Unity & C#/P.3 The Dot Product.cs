using System.Collections.Generic;
using UnityEngine;

public class Script3 : MonoBehaviour
{
    // Declare Variables
    public float[] inputs;
    public float[][] weights;
    public float[] biases;
    public float[] outputs;
    [HideInInspector]public List<float> results;

    // Start is called before the first frame update
    void Start()
    {
        // Set variable values
        inputs = new float[] { 1f, 2f, 3f, 2.5f };
        weights = new float[][]{new float[] { 0.2f, 0.8f, -0.5f, 1.0f },
                                new float[] { 0.5f, -0.91f, 0.26f, -0.5f },
                                new float[] { -0.26f, -0.27f, 0.17f, 0.87f }};
        biases = new float[] { 2, 3, 0.5f };
    }

    // Update is called once per frame
    void Update()
    {
        // Update outputs every frame. Outputs displayed in inspector for Game Object.
        // Changing values of variables updates outputs.
        outputs = LayerResults(weights, inputs, biases);
    }

    // Without adding external resources, create method to calculate Dot Product and add the bias.
    private float[] LayerResults(float[][] weights, float[] inputs, float[] biases)
    {
        results.Clear();
        for (int i = 0; i < weights.Length; i++)
        {
            float sum = 0;
            for (int j = 0; j < weights[i].Length; j++)
            {
                sum += weights[i][j] * inputs[j];
            }
            sum += biases[i];
            results.Add(sum);
        }
        return results.ToArray();
    }
}
