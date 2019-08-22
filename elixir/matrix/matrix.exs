defmodule Matrix do

  defstruct matrix: nil

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string input do
    %Matrix{ matrix: input
                     |> String.split(~r/\n/)
                     |> Enum.map(&String.split/1)
                     |> Enum.map(&list_to_integer/1) }
  end

  defp list_to_integer list do
    Enum.map list, &String.to_integer/1
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string matrix do
    extract_data_from(matrix) |> Enum.map_join("\n", &(Enum.join(&1, " ")))
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows matrix do
    extract_data_from matrix
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row matrix, index do
    rows(matrix) |> Enum.at(index)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns matrix do
    extract_data_from(matrix) |> Enum.zip |> Enum.map(&Tuple.to_list/1)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column matrix, index do
    columns(matrix) |> Enum.at(index)
  end

  defp extract_data_from matrix do
    %Matrix{ matrix: data } = matrix
    data
  end

end
