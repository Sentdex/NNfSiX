package main

import (
	"fmt"
	"math"

	"gonum.org/v1/gonum/mat"
)

func main() {
	softmax_output := mat.NewVecDense(3, []float64{0.7, 0.1, 0.2})
	target_output := mat.NewVecDense(3, []float64{1.0, 0.0, 0.0})

	var loss float64 = -(math.Log(softmax_output.AtVec(0))*target_output.AtVec(0) +
						 math.Log(softmax_output.AtVec(1))*target_output.AtVec(1) +
						 math.Log(softmax_output.AtVec(2))*target_output.AtVec(2))
	fmt.Printf("%f\n", loss)

	loss = -math.Log(softmax_output.AtVec(0))
	fmt.Printf("%f\n", loss)
}
