using UnityEngine;

public class Script1 : MonoBehaviour
{
    // Place this script on an empty Game Object and run.

    // Declare Variables
    public float[] inputs;
    public float[] weights;
    public float bias;
    public float output;
    // Start is called before the first frame update
    void Start()
    {
        //Set values of inputs, weights, and biases
        inputs = new float[] { 1.2f, 5.1f, 2.1f };
        weights = new float[] { 3.1f, 2.1f, 8.7f };
        bias = 3;
    }

    // Update is called once per frame
    void Update()
    {
        // Update output every frame. Output will be displayed in the inspector for that Game Object.
        output = inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias;
    }
}
