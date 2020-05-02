package NNfSiX.Java;

/*
* represents neural layer.
*/
public class NeuralLayer {
    double[][] inputs;
    double[][] weigths;
    double[] bais;

    NeuralLayer(int n_inputs, int n_neurons) {
        // randomly intialize weights
        // weights are set transposed..
        this.weigths = Utils.random(n_inputs, n_neurons, 0.35);
        this.bais = Utils.random(1, n_neurons, 1)[0];
    }

    public double[][] compute() {
        // output = input*weights + bais
        return Utils.add(Utils.dotProduct(inputs, weigths), bais);
    }
}