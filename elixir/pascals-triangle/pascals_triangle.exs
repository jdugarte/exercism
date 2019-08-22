defmodule PascalsTriangle do

  import Enum, only: [ reduce: 3, at: 2, sum: 1, chunk_every: 3 ]

  @doc """
  Calculates the rows of a pascal triangle
  with the given height
  """
  @spec rows(integer) :: [[integer]]
  def rows(num), do: reduce 0..num-1, [], &add_row/2

  defp add_row(row, triangle), do: triangle ++ [ (for n <- 0..row, do: triangle |> previous_row |> at(n) |> sum) ]

  defp previous_row(triangle), do: [ [1] | (triangle |> last_row |> chunk_every(2, 1)) ]

  defp last_row(triangle), do: List.last(triangle) || [1]

end
