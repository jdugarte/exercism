defmodule Luhn do

  @doc """
  Calculates the total checksum of a number
  """
  @spec checksum(String.t()) :: integer
  def checksum(number) do
    { doubled, rest } = calculate_digits number
    doubled |> Enum.concat(rest) |> Enum.sum
  end

  @doc """
  Checks if the given number is valid via the luhn formula
  """
  @spec valid?(String.t()) :: boolean
  def valid?(number) do
    rem(checksum(number), 10) == 0
  end

  @doc """
  Creates a valid number by adding the correct
  checksum digit to the end of the number
  """
  @spec create(String.t()) :: String.t()
  def create(number) do
    { doubled, rest } = calculate_digits number <> "0"
    digit = rest |> Enum.slice(0..-2) |> Enum.concat(doubled) |> Enum.sum |> Kernel.*(9) |> rem(10)
    "#{ number }#{ digit }"
  end

  defp calculate_digits(number) do
    digits = number |> String.graphemes |> Enum.map(&String.to_integer/1)
    to_double = digits |> Enum.reverse |> Enum.slice(1..-1) |> Enum.take_every(2)
    rest = digits -- to_double
    doubled = to_double |> Enum.map(&(if &1 > 4, do: &1*2-9, else: &1*2))
    { doubled, rest }
  end

end
