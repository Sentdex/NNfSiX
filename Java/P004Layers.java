package NNfSiX.Java;

/*
 * Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
 * Shows how to use NeuralNetwork and NeuralLayer.
 */
public class P004Layers {
    public static void main(String[] args) {
        // 1. Create a NeuralNetwork with input.
        NeuralNetwork network = new NeuralNetwork(
                new double[][] { { 1, 2, 3, 2.5 }, { 2, 5, -1, 2 }, { -1.5, 2.7, 3.3, -0.8 } });

        // 2. Add the first hidden layer to the network with 4 inputs and 5 neurons.
        network.addLayer(new NeuralLayer(4, 5));

        // 3. Add the second hidden layer to the network with 5 inputs from previous
        // layer and 2 outputs.
        network.addLayer(new NeuralLayer(5, 2));

        // 4. Do a forward pass of network and print the output.
        System.out.println("Output: ");
        Utils.print2dArr(network.forward());
    }
}