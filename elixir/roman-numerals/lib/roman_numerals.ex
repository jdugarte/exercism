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
  def numeral(number) do
    Enum.reduce(@roman_to_numeral, %{ number: number, roman: "" }, fn { letter, value }, data ->
      times = div(data[:number], value)
      %{
        number: data[:number] - times * value,
        roman:  data[:roman] <> String.duplicate(letter, times)
      }
    end)[:roman]
  end
end
