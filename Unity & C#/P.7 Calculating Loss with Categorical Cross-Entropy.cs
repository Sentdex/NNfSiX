using UnityEngine;

public class Script7 : MonoBehaviour
{
    public float[] softMaxOutput;
    public float loss;
    public float negativeMathLogPoint7 = -Mathf.Log(0.7f);
    public float negativeMathLogPoint5 = -Mathf.Log(0.5f);
    // Start is called before the first frame update
    void Start()
    {
        softMaxOutput = new float[] { 0.7f, 0.1f, 0.2f };
    }

    // Update is called once per frame
    void Update()
    {
        // Set boundary for softmax result between 0 and 1, so you can mess around with values
        // in the inspector for the first value and see how the results for loss change
        softMaxOutput[0] = Mathf.Clamp(softMaxOutput[0], 0, 1);
        // Dynamically Calculate loss. 
        loss = -Mathf.Log(softMaxOutput[0]);
    }
}
