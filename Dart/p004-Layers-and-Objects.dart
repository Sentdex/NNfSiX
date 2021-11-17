import 'dart:math';

Random rng = new Random(0);

void main() {
  List<List<double>> X = [
    [1.0, 2.0, 3.0, 2.5],
    [2.0, 5.0, -1.0, 2.0],
    [-1.5, 2.7, 3.3, -0.8]
  ];

  Layer_Dense layer1 = new Layer_Dense(4, 5);
  Layer_Dense layer2 = new Layer_Dense(5, 2);

  layer1.forward(X);
  layer2.forward(layer1.output);
  print(layer2.output);
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
