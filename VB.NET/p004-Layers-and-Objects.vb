Imports Accord.Math
Module p004_Layers_and_Objects
    ' Translation from https://github.com/Sentdex/NNfSiX/blob/master/C%23/p004-Layers-and-Objects.cs
    Public Class Layer_Dense
        ' Variables to be used in Dense Layer
        Private weights()() As Double
        Private biases() As Double = Nothing
        Public output()() As Double = Nothing
        Public Sub New(n_inputs As Integer, n_neurons As Integer)
            ' Initializing Double Jagged Array
            ReDim Preserve Me.weights(n_inputs - 1)
            ' Generating Random Matrix with Accord.Net
            For i As Integer = 0 To n_inputs - 1
                Me.weights(i) = Vector.Random(n_neurons)
            Next i
            ' Initializing Biases with Zero
            ReDim Preserve Me.biases(n_neurons - 1)
            For i As Integer = 0 To n_neurons - 1
                Me.biases(i) = 0
            Next i
        End Sub
        Public Sub Forward(inputs()() As Double)
            ' Calculating Dot Product using Accord.Net Math
            Me.output = Matrix.Dot(inputs, Me.weights)

            ' Adding Biases to Each output
            For i As Integer = 0 To output.Length - 1
                For j As Integer = 0 To output(i).Length - 1
                    Me.output(i)(j) = Math.Round(output(i)(j) + biases(j), 2)
                Next j
            Next i
        End Sub
    End Class
    Sub Main()
        ' Inputs
        Dim X()() As Double = {
                New Double() {1, 2, 3, 2.5},
                New Double() {2, 5, -1, 2},
                New Double() {-1.5, 2.7, 3.3, -0.8}
            }

        ' Defining Two Dense Layers
        Dim layer1 As New Layer_Dense(4, 5)
        Dim layer2 As New Layer_Dense(5, 2)

        ' Passing Input Data Through the Layers
        layer1.Forward(X)
        layer2.Forward(layer1.output) ' Passing Layer 1 Output As Input To Layer 2

        ' Displaying Jagged Array as Matrix in Console
        DisplayOutput(layer2.output)

        Console.Read()
    End Sub

    ' Method to Display Jagged Array as Matrix in Console
    Private Sub DisplayOutput(array As Double()())
        For i As Integer = 0 To array.Length - 1
            Dim output_string As String = "["
            For j As Integer = 0 To array(i).Length - 1
                output_string &= array(i)(j) & " ,"
            Next j
            output_string = output_string.TrimEnd(",")
            output_string &= "]"

            Console.WriteLine(output_string)
        Next i
    End Sub

End Module
