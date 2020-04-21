package main

import ("fmt")

func main() {
  inputs := [3]float64{1.2, 5.1, 2.1}
  weights := [3]float64{3.1, 2.1, 8.7}
  bias := 3.0

  output := inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias
  fmt.Println(output)
}
