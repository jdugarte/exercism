defmodule PerfectNumbers do

  @doc """
  Determine the aliquot sum of the given `number`, by summing all the factors
  of `number`, aside from `number` itself.

  Based on this sum, classify the number as:

  :perfect if the aliquot sum is equal to `number`
  :abundant if the aliquot sum is greater than `number`
  :deficient if the aliquot sum is less than `number`
  """
  @spec classify(number :: integer) :: ({ :ok, atom } | { :error, String.t() })
  def classify(number) when number < 1, do: { :error, "Classification is only possible for natural numbers." }
  def classify(number), do: { :ok, (number |> factors |> Enum.sum |> category(number)) }

  def category(number, number), do: :perfect
  def category(aliquot_sum, number) when aliquot_sum > number, do: :abundant
  def category(_, _), do: :deficient

  defp factors(number, candidate \\ 1)
  defp factors(number, number), do: []
  defp factors(number, candidate) when rem(number, candidate) != 0, do: factors number, candidate + 1
  defp factors(number, candidate), do: [ candidate | factors(number, candidate + 1) ]

end
