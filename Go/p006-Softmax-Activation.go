package main

import (
	"fmt"
	"math"
	"gonum.org/v1/gonum/mat"
)


func main() {
	layer_outputs := mat.NewVecDense(3, []float64{4.8, 1.21, 2.385})
	E := math.E

	exp_values := mat.NewVecDense(3, nil)

	for i := 0; i < layer_outputs.Len(); i++ {
		exp_values.SetVec(i, math.Pow(E, layer_outputs.AtVec(i)))
	}

	norm_base := mat.Sum(exp_values)
	norm_values := mat.NewVecDense(3, nil)

	for i := 0; i < exp_values.Len(); i++ {
		norm_values.SetVec(i, exp_values.AtVec(i)/norm_base)
	}

	fmt.Printf("%v\n%f\n", norm_values.RawVector().Data, mat.Sum(norm_values))
}
