Module p002_Basic_Neuron_Layer
    Sub Main(args As String())
        Dim inputs() As Double = {1.0, 2.0, 3.0, 2.5}
        Dim weights1() As Double = {0.2, 0.8, -0.5, 1.0}
        Dim weights2() As Double = {0.5, -0.91, 0.26, -0.5}
        Dim weights3() As Double = {-0.26, -0.27, 0.17, 0.87}

        Dim bias1 As Double = 2.0
        Dim bias2 As Double = 3.0
        Dim bias3 As Double = 0.5

        Dim output() As Double = {(inputs(0) * weights1(0) + inputs(1) * weights1(1) + inputs(2) * weights1(2) + inputs(3) * weights1(3) + bias1),
                                  (inputs(0) * weights2(0) + inputs(1) * weights2(1) + inputs(2) * weights2(2) + inputs(3) * weights2(3) + bias2),
                                  (inputs(0) * weights3(0) + inputs(1) * weights3(1) + inputs(2) * weights3(2) + inputs(3) * weights3(3) + bias3)}

        Console.WriteLine($"[{String.Join(", ", output)}]")
    End Sub
End Module
