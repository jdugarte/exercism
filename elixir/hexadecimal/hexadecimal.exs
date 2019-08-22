defmodule Hexadecimal do

  @doc """
    Accept a string representing a hexadecimal value and returns the
    corresponding decimal value.
    It returns the integer 0 if the hexadecimal is invalid.
    Otherwise returns an integer representing the decimal value.

    ## Examples

      iex> Hexadecimal.to_decimal("invalid")
      0

      iex> Hexadecimal.to_decimal("af")
      175

  """

  @digits ~w[ 0 1 2 3 4 5 6 7 8 9 A B C D E F ]

  @spec to_decimal(binary) :: integer
  def to_decimal(hex) do
    hex |> String.upcase |> String.graphemes |> Enum.reverse |> Enum.reduce_while([], fn digit, list ->
      case Enum.find_index(@digits, &(&1 == digit)) do
        nil   -> { :halt, [ 0 ] }
        value -> { :cont, [ (value * :math.pow(16, length(list))) | list ] }
      end
    end) |> Enum.sum
  end

end
