package nnfs

import (
	"math"
	"math/rand"

	"gonum.org/v1/gonum/mat"
)

// NewSpiralData generates spiral data. see: https://cs231n.github.io/neural-networks-case-study/
func NewSpiralData(numberOfPoints, numberOfClasses int) (*mat.Dense, *mat.Dense) {
	X := mat.NewDense(numberOfPoints*numberOfClasses, 2, nil)
	y := mat.NewDense(numberOfPoints*numberOfClasses, 1, nil)

	for c := 0; c < numberOfClasses; c++ {
		radius := linspace(0, 1, numberOfPoints)
		t := linspace(float64(c*4), float64((c+1)*4), numberOfPoints)
		for i := range t {
			t[i] += 0.2 * rand.NormFloat64()
		}
		for i := 0; i < numberOfPoints; i++ {
			X.Set(c*i, 0, radius[i]*math.Sin(t[i]*2.5))
			X.Set(c*i, 1, radius[i]*math.Cos(t[i]*2.5))
			y.Set(c*i, 0, float64(c))
		}
	}

	return X, y
}

func linspace(start, end float64, num int) []float64 {
	result := make([]float64, num)
	step := (end - start) / float64(num-1)
	for i := range result {
		result[i] = start + float64(i)*step
	}
	return result
}
