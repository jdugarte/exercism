defmodule PrimeFactors do

  import Enum, only: [ find: 2, reverse: 1, take_while: 2, all?: 2 ]

  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number), do: factors_for(number, [], [ next_prime([]) ])

  defp factors_for(1, factors, _), do: factors |> reverse
  defp factors_for(number, factors, [ prime | _ ] = primes) when rem(number, prime) == 0 do
    factors_for div(number, prime), [ prime | factors ], primes
  end
  defp factors_for(number, factors, primes) do
    factors_for number, factors, [ next_prime(primes) | primes ]
  end

  defp next_prime([]), do: 2
  defp next_prime([2]), do: 3
  defp next_prime(primes), do: primes |> hd |> +1 |> Stream.iterate(&(&1 + 1)) |> find(&(prime?(&1, primes)))
  defp prime?(number, primes) do
    limit = trunc(:math.sqrt(number))
    primes |> reverse |> take_while(&(&1 <= limit)) |> all?(&(rem(number, &1) != 0))
  end

end
