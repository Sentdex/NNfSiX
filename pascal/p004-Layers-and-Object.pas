program NeuralNetwork;

uses Math, SysUtils;

type
  TMatrix = array of array of Double;

  TLayerDense = class
  private
    weights: TMatrix;
    biases: TMatrix;
    output: TMatrix;
  public
    constructor Create(n_inputs, n_neurons: Integer);
    procedure Forward(inputs: TMatrix);
  end;

constructor TLayerDense.Create(n_inputs, n_neurons: Integer);
var
  i, j: Integer;
begin
  SetLength(weights, n_inputs, n_neurons);
  SetLength(biases, 1, n_neurons);
  for i := 0 to n_inputs - 1 do
    for j := 0 to n_neurons - 1 do
      weights[i, j] := 0.10 * Random - 0.05;
  FillChar(biases[0, 0], SizeOf(Double) * n_neurons, 0);
end;

procedure TLayerDense.Forward(inputs: TMatrix);
var
  i, j, k: Integer;
begin
  SetLength(output, Length(inputs), Length(weights[0]));
  for i := 0 to Length(inputs) - 1 do
    for j := 0 to Length(weights[0]) - 1 do
    begin
      output[i, j] := biases[0, j];
      for k := 0 to Length(inputs[0]) - 1 do
        output[i, j] := output[i, j] + inputs[i, k] * weights[k, j];
    end;
end;

var
  X: TMatrix;
  layer1, layer2: TLayerDense;
  i, j: Integer;
begin
  Randomize;

  SetLength(X, 3, 4);
  X[0] := [1, 2, 3, 2.5];
  X[1] := [2.0, 5.0, -1.0, 2.0];
  X[2] := [-1.5, 2.7, 3.3, -0.8];

  layer1 := TLayerDense.Create(4, 5);
  layer2 := TLayerDense.Create(5, 2);

  layer1.Forward(X);
  // WriteLn(layer1.output);
  layer2.Forward(layer1.output);

  for i := 0 to Length(layer2.output) - 1 do
  begin
    for j := 0 to Length(layer2.output[0]) - 1 do
      Write(layer2.output[i, j]:0:2, ' ');
    WriteLn;
  end;
end.
