package main

import (
	"fmt"
	"gonum.org/v1/gonum/mat"
)

func main() {
	inputs := mat.NewVecDense(4, []float64{1.0, 2.0, 3.0, 2.5})
	weights := []*mat.VecDense{
		mat.NewVecDense(4, []float64{0.2, 0.8, -0.5, 1.0}),
		mat.NewVecDense(4, []float64{0.5, -0.91, 0.26, -0.5}),
		mat.NewVecDense(4, []float64{-0.26, -0.27, 0.17, 0.87}),
	}

	output := mat.NewVecDense(3, nil)
	biases := mat.NewVecDense(3, []float64{2.0, 3.0, 0.5})

	for i := range weights {
		res := mat.Dot(inputs, weights[i])
		output.SetVec(i, res + biases.AtVec(i))
	}

	fmt.Printf("%v", output.RawVector().Data)
}
