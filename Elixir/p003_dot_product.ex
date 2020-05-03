defmodule P003DotProduct do
  @moduledoc """
  Create a basic neuron layer with dot product in Elixir

  Associated tutorial https://www.youtube.com/watch?v=tMrbN67U9d4
  """

  import Enum

  def calculate() do
    inputs = [1.0, 2.0, 3.0, 2.5]
    weights = [ [ 0.2, 0.8, -0.5, 1.0],
                [0.5, -0.91, 0.26, -0.5],
                [-0.26, -0.27, 0.17, 0.87] ]
    biases = [2.0, 3.0, 0.5]
    dot(inputs, weights, biases)
    |> IO.inspect
  end

  defp dot(inputs, weight), do:
    0..length(inputs) - 1
    |> reduce(0, fn i, acc -> acc + at(inputs, i) * at(weight, i) end)
  defp dot(inputs, weights, biases), do:
    0..length(weights) - 1
    |> reduce([], fn i, acc -> acc ++ [dot(inputs, at(weights, i)) + at(biases, i)] end)
    |> List.flatten

end
