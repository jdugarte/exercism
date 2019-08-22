defmodule Minesweeper do

  @doc """
  Annotate empty spots next to mines with the number of mines next to them.
  """
  @spec annotate([String.t]) :: [String.t]

  def annotate([]), do: []
  def annotate(board) do
    for i <- 0..length(board)-1 do
      for j <- 0..(board |> hd |> String.length |> -1), into: "" do
        if cell(board, i, j) == "*", do: "*", else: board |> mines(i, j)
      end
    end
  end

  defp cell(board, i, j), do: board |> Enum.at(i) |> String.at(j)

  defp mines(board, i, j) do
    case board |> surrounding(i, j) |> Enum.filter(&(&1 == "*")) |> length do
      0 -> " "
      n -> to_string(n)
    end
  end

  defp surrounding(board, i, j) do
    vertical_range   = max(0, i-1)..min(i+1, board |> length |> -1)
    horizontal_range = max(0, j-1)..min(j+1, board |> hd |> String.length |> -1)
    board
      |> Enum.slice(vertical_range)
      |> Enum.map(&(&1 |> String.slice(horizontal_range) |> String.graphemes))
      |> List.flatten
  end

end
