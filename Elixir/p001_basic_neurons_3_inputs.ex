defmodule P001BasicNeurons3Inputs do
  @moduledoc """
  Create a basic neuron with 3 inputs in Elixir

  Associated tutorial https://www.youtube.com/watch?v=Wo5dMEP_BbI
  """

  import Enum, only: [at: 2]

  def calculate() do
    inputs = [1.2, 5.1, 2.1]
    weights = [3.1, 2.1, 8.7]
    bias = 3.0

    at(inputs, 0) * at(weights, 0) + at(inputs, 1) * at(weights, 1) + at(inputs, 2) * at(weights, 2) + bias
    |> IO.inspect
  end

end
