Imports System

Module p001-Basic-Neuron-3-inputs
    Sub Main(args As String())
        Dim inputs() As Double = {1.2, 5.1, 2.1}
        Dim weights() As Double = {3.1, 2.1, 8.7}
        Dim bias As Double = 3

        Dim output As Double = inputs(0) * weights(0) + inputs(1) * weights(1) + inputs(2) * weights(2) + bias
        Console.WriteLine(output)
    End Sub
End Module
