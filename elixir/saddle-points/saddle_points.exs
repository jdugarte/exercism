defmodule SaddlePoints do

  import Enum, only: [ map: 2, with_index: 1, max: 1, min: 1 ]

  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(str) do
    for line <- String.split(str, "\n") do
      for char <- String.split(line, " ") do
        String.to_integer char
      end
    end
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(str), do: str |> rows |> List.zip |> map(&Tuple.to_list/1)

  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(str) do
    for { row, r } <- with_index(rows(str)), { col, c } <- with_index(columns(str)), max(row) == min(col), do: { r, c }
  end

end
