package NNfSiX.Java;

import java.util.ArrayList;
/**
 * represents a neural network.
 */
public class NeuralNetwork {
    private double[][] X;
    ArrayList<NeuralLayer> layers = new ArrayList<>();

    public NeuralNetwork(double[][] X) {
        this.X = X;
    }

    public void addLayer(NeuralLayer layer) {
        layers.add(layer);
    }

    public double[][] forward() {
        double[][] result = X;
        int count = 0;
        for (NeuralLayer layer : layers) {
            layer.inputs = result;
            result = layer.compute();
            System.out.println("Layer " + (count++) + " output:");
            Utils.print2dArr(result);
            System.out.println();
        }

        return result;
    }
}