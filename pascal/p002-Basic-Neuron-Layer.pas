program Neuron;
var
  inputs: array[0..3] of Real = (1, 2, 3, 2.5);
  weights1: array[0..3] of Real = (0.2, 0.8, -0.5, 1);
  weights2: array[0..3] of Real = (0.5, -0.91, 0.26, -0.5);
  weights3: array[0..3] of Real = (-0.26, -0.27, 0.17, 0.87);
  bias1, bias2, bias3: Real;
  output: array[0..2] of Real;
begin
  bias1 := 2;
  bias2 := 3;
  bias3 := 0.5;

  output[0] := (inputs[0] * weights1[0] + inputs[1] * weights1[1] + inputs[2] * weights1[2] + inputs[3] * weights1[3]) + bias1;
  output[1] := (inputs[0] * weights2[0] + inputs[1] * weights2[1] + inputs[2] * weights2[2] + inputs[3] * weights2[3]) + bias2;
  output[2] := (inputs[0] * weights3[0] + inputs[1] * weights3[1] + inputs[2] * weights3[2] + inputs[3] * weights3[3]) + bias3;

  WriteLn(output[0], ' ', output[1], ' ', output[2]);
end.
