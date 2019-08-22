defmodule Prime do

  import Enum, only: [ reduce: 3, find: 2, reverse: 1, take_while: 2, all?: 2 ]

  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count < 1, do: raise ArgumentError
  def nth(count) do
    1..count |> reduce([], fn _, primes -> [ next_prime(primes) | primes ] end) |> hd
  end

  defp next_prime([]),  do: 2
  defp next_prime([2]), do: 3
  defp next_prime(primes) do
    primes |> hd |> +(2) |> Stream.iterate(&(&1 + 2)) |> find(&(prime?(&1, primes)))
  end

  defp prime?(number, primes) do
    limit = Float.floor(:math.sqrt(number))
    primes |> reverse |> take_while(&(&1 <= limit)) |> all?(&(rem(number, &1) != 0))
  end

end
