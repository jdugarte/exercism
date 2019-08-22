defmodule Queens do

  @type t :: %Queens{ black: {integer, integer}, white: {integer, integer} }
  defstruct black: nil, white: nil

  @doc """
  Creates a new set of Queens
  """
  @spec new() :: Queens.t()
  @spec new({integer, integer}, {integer, integer}) :: Queens.t()
  def new white \\ {0, 3}, black \\ {7, 3} do
    if white == black, do: raise ArgumentError
    %Queens{ black: black, white: white }
  end

  @doc """
  Gives a string reprentation of the board with
  white and black queen locations shown
  """

  @row    List.duplicate "_",  8
  @board  List.duplicate @row, 8
  @pieces [ white: "W", black: "B" ]

  @spec to_string(Queens.t()) :: String.t()
  def to_string(queen), do: @board |> place(:white, queen) |> place(:black, queen) |> to_s

  defp to_s(board), do: Enum.map_join board, "\n", &Enum.join(&1, " ")

  defp place board, player, queens do
    { row, col } = Map.get queens, player
    List.replace_at board, row, List.replace_at(@row, col, @pieces[player])
  end

  @doc """
  Checks if the queens can attack each other
  """
  @spec can_attack?(Queens.t()) :: boolean
  def can_attack?(queens), do: queens.black <~> queens.white

  defp { black_row, black_col } <~> { white_row, white_col } do
    black_row == white_row or
    black_col == white_col or
    abs(black_row - white_row) == abs(black_col - white_col)
  end

end
