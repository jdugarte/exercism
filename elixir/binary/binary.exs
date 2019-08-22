defmodule Binary do

  @doc """
  Convert a string containing a binary number to an integer.

  On errors returns 0.
  """
  @spec to_decimal(String.t) :: non_neg_integer
  def to_decimal(string) do
    string |> String.graphemes |> Enum.reverse |> Enum.reduce_while([], fn digit, list ->
      case digit do
        "1" -> { :cont, [ :math.pow(2, length(list)) | list ] }
        "0" -> { :cont, [ 0 | list ] }
        _   -> { :halt, [ 0 ] }
      end
    end) |> Enum.sum
  end

end
