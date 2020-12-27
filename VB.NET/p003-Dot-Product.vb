Imports Accord.Math

Module p003_Dot_Product
    Public Sub Main(args As String())
        Dim inputs() As Double = {1.0, 2.0, 3.0, 2.5}

        ' Single Neuron
        'Dim weights() As Double = New Double() {0.2, 0.8, -0.5, 1.0}
        'Dim bias As Double = 2.0
        'Dim output As Double = Matrix.Dot(weights, inputs) + bias
        'Console.WriteLine(output)

        ' Multiple Neurons
        Dim weights = New Double(2, 3) {{0.2, 0.8, -0.5, 1.0}, {0.5, -0.91, 0.26, -0.5}, {-0.26, -0.27, 0.17, 0.87}}
        Dim biases() As Double = {2.0, 3.0, 0.5, 1.0}
        Dim outputs() As Double = weights.Dot(inputs).Add(biases)
        Console.WriteLine($"[{String.Join(", ", outputs)}]")
    End Sub
End Module
