defmodule Triangle do

  import Enum, only: [ sort: 1, dedup: 1 ]

  @type kind :: :equilateral | :isosceles | :scalene

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: { :ok, kind } | { :error, String.t }
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0, do: { :error, "all side lengths must be positive" }
  def kind(a, b, c) when a+b <= c or b+c <= a or a+c <= b, do: { :error, "side lengths violate triangle inequality" }
  def kind(a, a, a), do: { :ok, :equilateral }
  def kind(a, b, c), do: { :ok, [ a, b, c ] |> sort |> dedup |> check }

  defp check(sides) when length(sides) == 2, do: :isosceles
  defp check(_), do: :scalene

end
