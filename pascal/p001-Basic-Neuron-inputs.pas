program NeuronExample;

var
  inputs: array[0..2] of Real = (1.2, 5.1, 2.1);
  weights: array[0..2] of Real = (3.1, 2.1, 8.7);
  bias: Real = 3.0;
  output: Real;

begin
  output := inputs[0]*weights[0] + inputs[1]*weights[1] + inputs[2]*weights[2] + bias;
  WriteLn(output);
end.
