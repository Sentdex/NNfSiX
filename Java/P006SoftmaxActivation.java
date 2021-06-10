import java.util.Arrays;
import java.util.Random;

public class P006SoftmaxActivation {
  private static final Random random = new Random(0);

  public static void main(String[] args) {
    Dataset dataset = new Dataset();
    dataset.createData(100, 3);

    LayerDense layer1 = new LayerDense(2, 3);
    LayerDense layer2 = new LayerDense(3, 3);

    ActivationReLU activation1 = new ActivationReLU();
    ActivationSoftmax activation2 = new ActivationSoftmax();

    layer1.forward(dataset.X);
    activation1.forward(layer1.output);

    layer2.forward(activation1.output);
    activation2.forward(layer2.output);

    for(int i = 0; i < 5; i++) {
      System.out.println(Arrays.toString(activation2.output[i]));
    }
  }

  private static class Dataset {
    private double[][] X;
    private int[] Y;

    public void createData(int points, int classes) {
      X = new double[points * classes][2];
      Y = new int[points * classes];
      int ix = 0;
      for (int classNumber = 0; classNumber < classes; classNumber++) {
        double r = 0;
        double t = classNumber * 4;
        while (r <= 1 && t <= (classNumber + 1) * 4) {
          double randomT = t + random.nextInt(points) * 0.2;
          X[ix][0] = r * Math.sin(randomT * 2.5);
          X[ix][1] = r * Math.cos(randomT * 2.5);
          Y[ix] = classNumber;
          r += 1.0 / (points - 1);
          t += 4.0 / (points - 1);
          ix++;
        }
      }
    }
  }

  private static class LayerDense {
    private double[][] weights; // weights of the layer
    private double[] biases; // biases of the layer
    private double[][] output; // output of the layer.

    /**
     * Constructor for new densely connected layer.
     *
     * @param nInputs  Number of inputs coming into layer.
     * @param nNeurons Number of neurons in layer.
     */
    public LayerDense(int nInputs, int nNeurons) {
      this.weights = randn(nInputs, nNeurons);
      this.biases = new double[nNeurons];
    }

    /**
     * Feed forward method used to calculate output of layer.
     *
     * @param inputs Input to be used to calculate output.
     */
    public void forward(double[][] inputs) {
      output = add(dotProduct(inputs, weights), biases);
    }

    /**
     * Implementation of randn function from numpy, uses the built in gaussian
     * distribution from the java random class.
     *
     * @param rows How many rows the array should have.
     * @param cols How many columns the array should have.
     * @return The newly created gaussian distributed array.
     */
    public double[][] randn(int rows, int cols) {
      double[][] output = new double[rows][cols];
      for (int i = 0; i < output.length; i++) {
        for (int j = 0; j < output[0].length; j++) {
          output[i][j] = 0.1 * random.nextGaussian();
        }
      }
      return output;
    }

    /**
     * Updated to calculate the dot product of multidimensional arrays.
     *
     * @param input1 input array 1.
     * @param input2 input array 2
     * @return Newly created dot product of parameter arrays.
     */
    private static double[][] dotProduct(double[][] input1, double[][] input2) {
      double[][] output = new double[input1.length][input2[0].length];
      for (int i = 0; i < output.length; i++) {
        for (int j = 0; j < output[0].length; j++) {
          double value = 0;
          for (int k = 0; k < input1[0].length; k++) {
            value += input1[i][k] * input2[k][j];
          }
          output[i][j] = value;
        }
      }
      return output;
    }

    /**
     * Updated to add a 2 dimensional array to a one dimensional array.
     *
     * @param input1 Two dimensional array
     * @param input2 One dimensional array.
     * @return Newly created array of sum of parameter arrays.
     */
    private static double[][] add(double[][] input1, double[] input2) {
      double[][] output = new double[input1.length][input1[0].length];
      for (int i = 0; i < input1.length; i++) {
        for (int j = 0; j < input1[0].length; j++) {
          output[i][j] = input1[i][j] + input2[j];
        }
      }
      return output;
    }

  }

  private static class ActivationReLU {
    private double[][] output;

    /**
     * Feed forward method used to calculate ReLU output of layer.
     *
     * @param inputs Input to be used to calculate output.
     */
    public void forward(double[][] inputs) {
      output = new double[inputs.length][inputs[0].length];
      for (int i = 0; i < output.length; i++) {
        for (int j = 0; j < output[0].length; j++) {
          if (inputs[i][j] > 0) {
            output[i][j] = 0;
          } else {
            output[i][j] = inputs[i][j];
          }
        }
      }
    }
  }

  private static class ActivationSoftmax {
    private double[][] output;

    /**
     * Feed forward method used to calculate Softmax output of layer.
     * 
     * @param inputs Input to be used to calculate output.
     */
    private void forward(double[][] inputs) {
      double[][] expValues = new double[inputs.length][inputs[0].length];
      for (int i = 0; i < inputs.length; i++) {
        double[] dup = inputs[i];
        Arrays.sort(dup);

        for (int j = 0; j < inputs[0].length; j++) {
          expValues[i][j] = Math.pow(Math.E, inputs[i][j] - dup[dup.length - 1]);
        }
      }

      double[] normBase = new double[inputs.length];
      for (int i = 0; i < expValues.length; i++) {
        double sum = 0.0;
        for (double expValue : expValues[i]) {
          sum += expValue;
        }
        normBase[i] = sum;
      }

      double[][] normValues = new double[inputs.length][inputs[0].length];
      for (int i = 0; i < expValues.length; i++) {
        for (int j = 0; j < expValues[0].length; j++) {
          normValues[i][j] = expValues[i][j] / normBase[i];
        }
      }

      output = normValues;
    }
  }
}
