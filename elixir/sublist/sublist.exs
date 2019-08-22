defmodule Sublist do

  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b        -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true           -> :unequal
    end
  end

  defp sublist?([], [_|_]), do: true
  defp sublist?(a, b) do
    # same thing, but slower
    # Stream.chunk(b, length(a), 1) |> Enum.any?(&(&1 === a))
    len_a = length a
    len_b = length b
    cond do
      len_a > len_b -> false
      true -> 0..len_b-len_a |> Enum.any?(fn(n) -> a === Enum.slice(b, n..len_a+n-1) end)
    end
  end

end
