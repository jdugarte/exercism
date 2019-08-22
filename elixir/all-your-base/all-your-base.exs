defmodule AllYourBase do

  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list
  def convert([], _, _), do: nil
  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil
  def convert(digits, base_a, base_b) do
    if valid?(digits, base_a), do: digits |> to_10(base_a) |> to_base(base_b, [])
  end

  defp valid?(digits, base), do: Enum.all?(digits, &(&1 in 0..base-1))

  defp to_10([], _), do: 0
  defp to_10([ digit | tail ], base) do
    trunc(digit * :math.pow(base, length(tail))) + to_10(tail, base)
  end

  defp to_base(0, _, []), do: [0]
  defp to_base(0, _, digits), do: digits
  defp to_base(number, base, digits) do
    to_base div(number, base), base, [ rem(number, base) | digits ]
  end

end
