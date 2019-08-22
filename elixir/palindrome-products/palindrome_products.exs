defmodule Palindromes do

  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1) do
    (for i <- min_factor..max_factor, j <- i..max_factor, palindrome?(i*j), do: { i*j, [ i, j ] })
      |> Enum.reduce(%{}, fn { palindrome, factors }, results ->
           Map.update results, palindrome, [ factors ], &[ factors | &1 ]
         end)
  end

  defp palindrome?(n), do: n == n |> Integer.digits |> Enum.reverse |> Integer.undigits

end
