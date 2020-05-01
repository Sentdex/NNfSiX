/*
Associated YT tutorial: https://youtu.be/TEWy9vZcxW4
*/

package main

import (
	"fmt"
	"math/rand"

	"gonum.org/v1/gonum/mat"
)

type LayerDense struct {
	Weights *mat.Dense
	Biases  *mat.Dense
	Output  *mat.Dense
}

func NewLayerDense(numberOfInputs, numberOfNeurons int) *LayerDense {
	randData := make([]float64, numberOfInputs*numberOfNeurons)
	for i := range randData {
		randData[i] = 0.10 * rand.NormFloat64()
	}
	return &LayerDense{
		Weights: mat.NewDense(numberOfInputs, numberOfNeurons, randData),
		Biases:  mat.NewDense(1, numberOfNeurons, nil),
	}
}

func (l *LayerDense) Forward(input *mat.Dense) {
	var mulRes mat.Dense
	mulRes.Mul(input, l.Weights)
	l.Output = mat.NewDense(mulRes.RawMatrix().Rows, mulRes.RawMatrix().Cols, nil)
	for i := 0; i < mulRes.RawMatrix().Rows; i++ {
		for j := 0; j < mulRes.RawMatrix().Cols; j++ {
			output := mulRes.At(i, j) + l.Biases.At(0, j)
			l.Output.Set(i, j, output)
		}
	}
}

func main() {
	rand.Seed(0)
	X := mat.NewDense(3, 4, []float64{1, 2, 3, 2.5, 2.0, 5.0, -1.0, 2.0, -1.5, 2.7, 3.3, -0.8})
	layer1 := NewLayerDense(4, 5)
	layer2 := NewLayerDense(5, 2)
	layer1.Forward(X)
	// fmt.Println(layer1.Output)
	layer2.Forward(layer1.Output)
	fmt.Print(layer2.Output)
}
