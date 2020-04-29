#!/usr/bin/awk -f


## Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
## For more complex examples check: https://github.com/awk-utilities/machine-learning-examples


BEGIN {
  split("1.0, 2.0, 3.0, 2.5", _inputs, ", ")
  split("0.2, 0.8, -0.5, 1.0; 0.5, -0.91, 0.26, -0.5; -0.26, -0.27, 0.17, 0.87", _weight_rows, "; ")
  split("2.0; 3.0; 0.5", _biases, "; ")
  split("1.0, 2.0, 3.0, 2.5", _inputs, ", ")

  _layer_results = ""
  for (_neuron_key in _weight_rows) {
    split(_weight_rows[_neuron_key], _weights, ", ")
    _bias = _biases[_neuron_key]
    _dot_result = ""
    for (_key in _weights) {
      _dot_result = _dot_result + _inputs[_key] * _weights[_key]
    }
    _neuron_result = _dot_result + _bias

    if (length(_layer_results)) {
      _layer_results = _layer_results "; " _neuron_result
    } else {
      _layer_results = _neuron_result
    }
  }

  print _layer_results
}
