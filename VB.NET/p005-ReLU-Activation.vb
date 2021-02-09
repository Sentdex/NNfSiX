'
' * Class Definition of ReLU Activation And spiral dataset
' * Based on nnfs.io by Harrison Kinsley & Daniel Kukiela
' * p005 from YT tutorial for the book: https : //youtu.be/gmjzbpSVY1A
' * spiral dataset code based on: https : //gist.github.com/Sentdex/454cb20ec5acf0e76ee8ab8448e6266c
' * spiral datase here defined as a function that returns a matrix X
' * 
' * Uses MathNet Numerics v4.11 by C.Ruegg, M. Cuda And J. Van Gael for vectors And matrix functions. 
' * To install in MSVS select Menu Project/Mangage NuGet packages...
' * in Browse tab search for MathNet.Numerics And install core package
'
' Transation from https://github.com/Sentdex/NNfSiX/blob/master/C%23/p005-ReLU-Activation.cs

Imports MathNet.Numerics
Imports MathNet.Numerics.LinearAlgebra

Module p005_ReLU_Activation

    Sub Main()
        'Inputs, the matrix X Is created using spiral_data which Is a member of the object program_p005
        Dim X As Matrix(Of Double) = spiral_data(100, 3)
        ' creates one dense layer And one activation layer
        Dim layer1 As Layer_Dense = New Layer_Dense(2, 5) ' 2 inputs, 5 neurons
        Dim activation1 As Activation_ReLU = New Activation_ReLU()

        ' call forward function of layer1 using X matrix as inputs
        layer1.Forward(X)

        ' call forward function activation1 using outputs from layer 1
        activation1.Forward(layer1.output)

        ' print results
        ' Console.WriteLine("\nInput matrix X (spiral data):")
        ' Console.WriteLine(X.ToString())

        Console.WriteLine("Forward method layer 1, outputs1:")
        Console.WriteLine(layer1.output.ToString())

        Console.WriteLine("Forward method activation 1 ReLU, outputs1: (100x3) x 5 neurons")
        Console.WriteLine(activation1.output.ToString())

        Console.ReadLine()
    End Sub

    ' define dataset
    Private Function spiral_data(points As Integer, classes As Integer) As Matrix(Of Double)
        ' Matrix<double> X;
        ' Vector<double> y;
        Dim M As MatrixBuilder(Of Double) = Matrix(Of Double).Build   ' shortcut to Matrix builder
        Dim V As VectorBuilder(Of Double) = Vector(Of Double).Build   ' shortcut to Vector builder

        ' build vectors of size points*classesx1 for y, r And theta
        Dim y As Vector(Of Double) = V.Dense(points * classes) ' at this point this Is full of zeros
        For j As Integer = 0 To classes - 1
            Dim y_step As Vector(Of Double) = V.DenseOfArray(Generate.Step(points * classes, 1, (j + 1) * points))
            y = y + y_step
        Next j
        Dim r As Vector(Of Double) = V.DenseOfArray(Generate.Sawtooth(points * classes, points, 0, 1))
        Dim theta As Vector(Of Double) = 4 * (r + y) + (V.DenseOfArray(Generate.Standard(points * classes)) * 0.2)
        Dim sin_theta As Vector(Of Double) = theta.PointwiseSin()
        Dim cos_theta As Vector(Of Double) = theta.PointwiseCos()

        Dim X As Matrix(Of Double) = M.DenseOfColumnVectors(r.PointwiseMultiply(sin_theta), r.PointwiseMultiply(cos_theta))
        Return X
    End Function

    'Define Layer_Dense class
    Public Class Layer_Dense
        ' attributes
        Public weithgts As Matrix(Of Double)  ' make them Public attributs To be visible at program level
        Public biases As Matrix(Of Double)    'define As "horizontal" vector Or 1xn matrix
        Public output As Matrix(Of Double)   'matrix With outputs

        'constructor
        Sub New(n_inputs As Integer, n_neurons As Integer)
            Dim M As MatrixBuilder(Of Double) = Matrix(Of Double).Build
            Dim v As VectorBuilder(Of Double) = Vector(Of Double).Build

            'creates a n_inputs x n_neurons random matrix And assign to weights
            weithgts = M.Random(n_inputs, n_neurons)

            'creates a zero filled vector, this has to be a horizontal vector, hense using a 1xn matrix
            biases = M.Dense(1, n_neurons)
        End Sub

        'Forward function
        Public Sub Forward(inputs As Matrix(Of Double))
            'creates a Matrix of size: (batches x 1) , this Is just an aux "vector"
            Dim M As MatrixBuilder(Of Double) = Matrix(Of Double).Build
            Dim v As Matrix(Of Double) = M.Dense(inputs.RowCount, 1, 1)
            ' multiply matrix v*biases: (batches x 1) dot (1 x neurons) = (batches x neurons) where each row Is the same as the horizontal biases vector
            Dim biasm As Matrix(Of Double) = v * biases ' biasm Is a matrix where Each row Is identical And the rows are the biases horizontal vector
            'now bias matrix can be added to inputs*weights
            Me.output = inputs * weithgts + biasm
        End Sub
    End Class

    'Define ReLU Activation Class
    Public Class Activation_ReLU
        ' attributes
        Public output As Matrix(Of Double)   ' matrix With outputs

        ' Forward function
        Public Sub Forward(inputs As Matrix(Of Double))
            output = inputs.PointwiseMaximum(0)
        End Sub
    End Class
End Module
