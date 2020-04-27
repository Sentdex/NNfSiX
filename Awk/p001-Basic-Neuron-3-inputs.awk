#!/usr/bin/awk -f


## Associated YT NNFS tutorial: https://www.youtube.com/watch?v=Wo5dMEP_BbI
## For more complex examples check: https://github.com/awk-utilities/machine-learning-examples


BEGIN {
  split("1.2, 5.1, 2.1", _inputs, ", ")
  split("3.1, 2.1, 8.7", _weights, ", ")
  _bias = 3.0
  _dot_result = ""
  for (_key in _weights) {
    _dot_result = _dot_result + _inputs[_key] * _weights[_key]
  }
  _result = _dot_result + _bias
}
