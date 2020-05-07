package NNfSiX.Java;

/*
 * Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
 * Shows how to use NeuralNetwork and NeuralLayer.
 */
public class P004Layers {
    public static void main(String[] args) {
        double[][] inputs = new double[][] { { 1, 2, 3, 2.5 }, { 2, 5, -1, 2 }, { -1.5, 2.7, 3.3, -0.8 } };
        Layer_Dense layer1 = new Layer_Dense(4, 5);
        layer1.inputs = inputs;
        Layer_Dense layer2 = new Layer_Dense(5, 2);
        layer2.inputs = layer1.forward();
        double[][] output = layer2.forward();
        Utils.print2dArr(output);
    }
}
class Layer_Dense {
    double[][] weights;
    double[][] inputs;
    double[] bais;
    
    Layer_Dense(int num_of_inputs, int num_of_neurons) {
        this.weigths = Utils.random(num_of_inputs, num_of_neurons, 0.35);
        this.bais = Utils.random(1, num_of_neurons, 1)[0];
    }
    
    double[][] forward() {
        return Utils.add(Utils.dotProduct(inputs, weigths), bais);
    }
}
