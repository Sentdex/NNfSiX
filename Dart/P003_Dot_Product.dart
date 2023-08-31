/**
 * Create a basic neuron layer with dot product in Dart
 * Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
 */

void main() {
  List<double> inputs = [1, 2, 3, 2.5];
  List<List<double>> weights = [
    [0.2, 0.8, -0.5, 1.0],
    [0.5, -0.91, 0.26, -0.5],
    [-0.26, -0.27, 0.17, 0.87]
  ];

  List<double> biases = [2, 3, 0.5];

  var intermdtOutputs = dotProduct(weights: weights, inputs: inputs);

  var finalOutputs = addVectors(interOutputs: intermdtOutputs, biases: biases);

  print(finalOutputs);
}

List<double> dotProduct(
    {required List<List<double>> weights, required List<double> inputs}) {
  List<double> layerOutputs = [];

  for (List<double> singleWeight in weights) {
    double neuronOutput = 0;
    for (int i = 0; i < singleWeight.length; i++) {
      neuronOutput = neuronOutput + singleWeight[i] * inputs[i];
    }
    layerOutputs.add(neuronOutput);
  }

  return layerOutputs;
}

List<double> addVectors(
    {required List<double> interOutputs, required List<double> biases}) {
  List<double> output = [];

  for (int i = 0; i < interOutputs.length; i++) {
    output.add(interOutputs[i] + biases[i]);
  }

  return output;
}
