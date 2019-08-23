defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """

  @roman_to_numeral [
    { "M",  1000 },
    { "CM", 900 },
    { "D",  500 },
    { "CD", 400 },
    { "C",  100 },
    { "XC", 90 },
    { "L",  50 },
    { "XL", 40 },
    { "X",  10 },
    { "IX", 9 },
    { "V",  5 },
    { "IV", 4 },
    { "I",  1 }
  ]

  @spec numeral(pos_integer) :: String.t()
  def numeral(number), do: to_roman(number, @roman_to_numeral)

  defp to_roman(0, _), do: ""
  defp to_roman(number, [ { letter, value } | tail ]) do
    times = div(number, value)
    String.duplicate(letter, times) <> to_roman(number - times * value, tail)
  end
end
