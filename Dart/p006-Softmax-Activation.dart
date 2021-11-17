import 'dart:math';

Random rng = new Random(0);

void main() {
  Dataset dataset = new Dataset();
  dataset.generate_data(100, 3);

  Layer_Dense dense1 = Layer_Dense(2, 3);
  Activation_ReLU activation1 = Activation_ReLU();

  Layer_Dense dense2 = Layer_Dense(3, 3);
  Activation_SoftMax activation2 = Activation_SoftMax();

  dense1.forward(dataset.X);
  activation1.forward(dense1.output);

  dense2.forward(activation1.output);
  activation2.forward(dense2.output);

  print(activation2.output);
}

class Layer_Dense {
  late List<List<double>> output;
  late List<List<double>> weights;
  late List<double> biases;

  Layer_Dense(int n_inputs, int n_neurons) {
    weights = [];
    for (int i = 0; i < n_inputs; i++) {
      List<double> temp = [];
      for (int j = 0; j < n_neurons; j++) {
        temp.add(rng.nextDouble() * 0.1);
      }
      weights.add(temp);
    }
    biases = new List<double>.filled(n_neurons, 0);
    output = new List<List<double>>.filled(n_neurons, []);
  }

  void forward(List<List<double>> inputs) {
    output = inputs.dot(weights).addList(biases);
  }
}

class Activation_ReLU {
  late List<List<double>> output;

  Activation_ReLU() {
    output = [];
  }

  void forward(List<List<double>> inputs) {
    output =
        inputs.map((e) => e.map((f) => max(0, f).toDouble()).toList()).toList();
  }
}

class Activation_SoftMax {
  late List<List<double>> output;

  Activation_SoftMax() {
    output = [];
  }

  void forward(List<List<double>> inputs) {
    List<List<double>> exp_values = inputs
        .map((row) => row.map((e) => exp(e - row.max())).toList())
        .toList();
    output = exp_values
        .map((row) => row.map((e) => e / row.sum()).toList())
        .toList();
  }
}

// def forward(self, inputs):
//         exp_values = np.exp(inputs - np.max(inputs, axis=1, keepdims=True))
//         probabilities = exp_values / np.sum(exp_values, axis=1, keepdims=True)
//         self.output = probabilities

/**
 * Everything below is implementation of numpy in dart
 */

extension NNFSV on List<double> {
  // dot product of 2 1D array
  num dot(List list) {
    if (this.length != list.length) {
      throw new Exception("Lists must be the same size");
    } else {
      num result = 0;
      for (int i = 0; i < this.length; i++) {
        result += this[i] * list[i];
      }
      return result;
    }
  }

  // add 1D array to another
  List addList(List list) {
    if (this.length != list.length) {
      throw new Exception("Lists must be the same length");
    }
    return zip({this, list}).map((e) => e[0] + e[1]).toList();
  }

  // get max value from 1D array
  double max() {
    double max_value = -100;
    for (var i in this) {
      if (i > max_value) {
        max_value = i;
      }
    }
    return max_value;
  }

  // get sum of a 1D array
  double sum() {
    double sum = 0;
    for (var i in this) {
      sum += i;
    }
    return sum;
  }
}

// extension to allow numpy functions on 2D list
extension NNFSM on List<List<double>> {
  // dot product of 2 2D arrays
  List<List<double>> dot(List<List<double>> list) {
    var result = new List<double>.filled(this.length, 0)
        .map((e) => List<double>.filled(list[0].length, 0))
        .toList();
    for (var r = 0; r < this.length; r++) {
      for (var c = 0; c < list[0].length; c++) {
        for (var i = 0; i < this[0].length; i++) {
          result[r][c] += this[r][i] * list[i][c];
        }
      }
    }
    return result;
  }

  // transpose 2D array
  List T() {
    List<List<double>> out = [];
    var x = this.length;
    var y = this[0].length;
    var N = x > y ? x : y;
    var M = y < x ? y : x;
    for (int n = 0; n < N; n++) {
      for (int m = 0; m < M; m++) {
        var a = x > y ? n : m;
        var b = y < x ? m : n;
        if (out.length <= b) {
          out.add([]);
        }
        out[b].add(this[a][b]);
      }
    }
    return out;
  }

  // add 1D array to 2D array
  List<List<double>> addList(List<double> list) {
    if (this[0].length != list.length) {
      throw new Exception("List indicies must have same length");
    }
    return this
        .map((e) => zip({e, list}).map((j) => j[0] + j[1]).toList())
        .toList();
  }
}

// for zipping two arrays like python, from:
// https://pub.dev/documentation/quiver/latest/quiver.iterables/zip.html
Iterable<List<T>> zip<T>(Iterable<Iterable<T>> iterables) sync* {
  if (iterables.isEmpty) return;
  final iterators = iterables.map((e) => e.iterator).toList(growable: false);
  while (iterators.every((e) => e.moveNext())) {
    yield iterators.map((e) => e.current).toList(growable: false);
  }
}

// for generating spiral dataset
class Dataset {
  late List<List<double>> X;
  late List<int> y;

  Dataset() {
    X = [];
    y = [];
  }

  void generate_data(int points, int classes) {
    X = [];
    y = new List<int>.filled(points * classes, 0);
    int ix = 0;
    for (int class_number = 0; class_number < classes; class_number++) {
      double r = 0;
      double t = class_number * 4;

      while (r <= 1 && t <= (class_number + 1) * 4) {
        double random_t = t + rng.nextInt(points) * 0.2;
        List<double> temp = [r * sin(random_t * 2.5), r * cos(random_t * 2.5)];
        y[ix] = class_number;

        X.add(temp);

        r += 1.0 / (points - 1);
        t += 4.0 / (points - 1);

        ix++;
      }
    }
  }
}
