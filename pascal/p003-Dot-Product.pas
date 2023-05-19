uses Math;

var
  inputs: array[0..3] of Double = (1, 2, 3, 2.5);
  weights: array[0..2, 0..3] of Double = ((0.2, 0.8, -0.5, 1), (0.5, -0.91, 0.26, -0.5), (-0.26, -0.27, 0.17, 0.87));
  biases: array[0..2] of Double = (2, 3, 0.5);
  output: array[0..2] of Double;
  i, j: Integer;
begin
  for i := 0 to 2 do
  begin
    output[i] := biases[i];
    for j := 0 to 3 do
      output[i] := output[i] + weights[i, j] * inputs[j];
  end;
  
  for i := 0 to 2 do
    WriteLn(output[i]);
end.
