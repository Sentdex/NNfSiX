using UnityEngine;

public class Script2 : MonoBehaviour
{
    // Place this script on an empty Game Object and run.

    // Declare Variables
    public float[] inputs;
    public float[] weights1, weights2, weights3;
    public float bias1, bias2, bias3;
    public float[] output;

    // Start is called before the first frame update
    void Start()
    {
        // Set values of variables
        inputs = new float[] { 1f, 2f, 3f, 2.5f };
        weights1 = new float[] { 0.2f, 0.8f, -0.5f, 1.0f };
        weights2 = new float[] { 0.5f, -0.91f, 0.26f, -0.5f };
        weights3 = new float[] { -0.26f, -0.27f, 0.17f, 0.87f };
        bias1 = 2;
        bias2 = 3;
        bias3 = 0.5f;
    }

    // Update is called once per frame
    void Update()
    {
        // Update output every frame. Output displayed in inspector of Game Object.
        // Changing variables in inspector, changes output values.
        output = new float[] { inputs[0] * weights1[0] + inputs[1] * weights1[1] + inputs[2] * weights1[2] + inputs[3] * weights1[3] + bias1,
                               inputs[0] * weights2[0] + inputs[1] * weights2[1] + inputs[2] * weights2[2] + inputs[3] * weights2[3] + bias2,
                               inputs[0] * weights3[0] + inputs[1] * weights3[1] + inputs[2] * weights3[2] + inputs[3] * weights3[3] + bias3};
    }
}
