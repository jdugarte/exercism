defmodule Series do

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t, non_neg_integer) :: non_neg_integer
  def largest_product(_, size) when size == 0, do: 1
  def largest_product(number_string, size) do
    if size < 1 or size > String.length(number_string), do: raise ArgumentError
    number_string
      |> String.to_integer
      |> Integer.digits
      |> Enum.chunk_every(size, 1, :discard)
      |> Enum.map(fn serie -> Enum.reduce(serie, &*/2) end)
      |> Enum.max(fn -> 0 end)
  end

end
