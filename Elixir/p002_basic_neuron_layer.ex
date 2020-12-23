defmodule P002BasicNeuronLayer do
  @moduledoc """
  Create a basic neuron layer in Elixir

  Associated tutorial https://www.youtube.com/watch?v=lGLto9Xd7bU
  """

  import Enum, only: [at: 2]

  def calculate() do
    inputs = [1.0, 2.0, 3.0, 2.5]
    weights1 = [0.2, 0.8, -0.5, 1.0]
    weights2 = [0.5, -0.91, 0.26, -0.5]
    weights3 = [-0.26, -0.27, 0.17, 0.87]
    bias1 = 2.0
    bias2 = 3.0
    bias3 = 0.5

    [at(inputs, 0) * at(weights1, 0) + at(inputs, 1) * at(weights1, 1) + at(inputs, 2) * at(weights1, 2) + at(inputs, 3) * at(weights1, 3) + bias1,
     at(inputs, 0) * at(weights2, 0) + at(inputs, 1) * at(weights2, 1) + at(inputs, 2) * at(weights2, 2) + at(inputs, 3) * at(weights2, 3) + bias2,
     at(inputs, 0) * at(weights3, 0) + at(inputs, 1) * at(weights3, 1) + at(inputs, 2) * at(weights3, 2) + at(inputs, 3) * at(weights3, 3) + bias3]
    |> IO.inspect
  end

end
