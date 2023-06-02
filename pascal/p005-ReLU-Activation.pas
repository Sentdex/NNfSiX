program SpiralData;

uses
  SysUtils, Math;

type
  TLayerDense = record
    weights: array of array of Double;
    biases: array of Double;
    output: array of Double;
  end;

  TActivationReLU = record
    output: array of Double;
  end;

procedure InitializeLayerDense(var layer: TLayerDense; nInputs, nNeurons: Integer);
var
  i, j: Integer;
begin
  SetLength(layer.weights, nInputs, nNeurons);
  SetLength(layer.biases, 1, nNeurons);

  for i := 0 to nInputs - 1 do
    for j := 0 to nNeurons - 1 do
      layer.weights[i, j] := 0.10 * Random - 0.05;

  FillChar(layer.biases[0], nNeurons * SizeOf(Double), 0);
end;

procedure ForwardLayerDense(var layer: TLayerDense; inputs: array of array of Double);
var
  i, j: Integer;
begin
  SetLength(layer.output, Length(inputs), Length(layer.biases[0]));

  for i := 0 to High(inputs) do
    for j := 0 to High(layer.biases[0]) do
      layer.output[i, j] := inputs[i, 0] * layer.weights[0, j] +
                            inputs[i, 1] * layer.weights[1, j] +
                            layer.biases[0, j];
end;

procedure InitializeActivationReLU(var activation: TActivationReLU; inputs: array of array of Double);
var
  i, j: Integer;
begin
  SetLength(activation.output, Length(inputs), Length(inputs[0]));

  for i := 0 to High(inputs) do
    for j := 0 to High(inputs[0]) do
      activation.output[i, j] := Max(0, inputs[i, j]);
end;

var
  layer1: TLayerDense;
  activation1: TActivationReLU;
  X, y: array of array of Double;
  i, j: Integer;
begin
  Randomize;

  SetLength(X, 100, 2);
  SetLength(y, 100, 1);

  // Assign values to X and y arrays

  InitializeLayerDense(layer1, 2, 5);
  ForwardLayerDense(layer1, X);

  InitializeActivationReLU(activation1, layer1.output);

  for i := 0 to High(activation1.output) do
  begin
    for j := 0 to High(activation1.output[0]) do
      Write(activation1.output[i, j]:0:2, ' ');
    Writeln;
  end;
end.
