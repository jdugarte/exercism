defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    convert_to_roman(number, 0)
  end

  defp convert_to_roman(0, _), do: ""

  defp convert_to_roman(number, position) do
    digit = rem(number, 10)
    offset = position * 2

    roman =
      cond do
        digit <= 3 -> unit_at(offset, digit)
        digit == 4 -> unit_at(offset) <> unit_at(offset + 1)
        digit <= 8 -> unit_at(offset + 1) <> unit_at(offset, digit - 5)
        digit == 9 -> unit_at(offset) <> unit_at(offset + 2)
      end

    convert_to_roman(div(number, 10), position + 1) <> roman
  end

  @romans ~w[ I V X L C D M ]

  defp unit_at(offset, times \\ 1), do: @romans |> Enum.at(offset) |> String.duplicate(times)
end
