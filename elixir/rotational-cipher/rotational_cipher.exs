defmodule RotationalCipher do

  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    cipher = shift_by shift
    text |> String.graphemes |> Enum.map_join(&(cipher[&1] || &1))
  end

  defp shift_by n do
    lower    = ?a..?z |> Enum.to_list |> to_string |> String.graphemes
    upper    = ?A..?Z |> Enum.to_list |> to_string |> String.graphemes
    original = lower ++ upper
    shifted  = Enum.drop(lower, n) ++ Enum.take(lower, n) ++ Enum.drop(upper, n) ++ Enum.take(upper, n)
    Map.new Enum.zip(original, shifted)
  end


  def rotate2(text, shift) do
    for <<int_char <- text>>, into: "", do: <<shift_integer_in_range(int_char, shift)>>
  end

  defp shift_integer_in_range(int_char, shift) when int_char in ?a..?z, do: ?a + rem((int_char + shift - ?a), 26)
  defp shift_integer_in_range(int_char, shift) when int_char in ?A..?Z, do: ?A + rem((int_char + shift - ?A), 26)
  defp shift_integer_in_range(int_char, _), do: int_char

end
