defmodule Sieve do

  @doc """
  Generates a list of primes up to a given limit.
  """
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(limit), do: 2..limit |> Enum.to_list |> primes_in_list

  defp primes_in_list(_, primes \\ [])
  defp primes_in_list([], primes), do: Enum.reverse primes
  defp primes_in_list([ prime | remaining ], primes) do
    primes_in_list remove_multiples(Enum.reverse(remaining), prime), [ prime | primes ]
  end

  defp remove_multiples(_, _, i \\ 1)
  defp remove_multiples([], _, _), do: []
  defp remove_multiples([ last | _ ] = list, number, i) when number * i > last, do: Enum.reverse list
  defp remove_multiples(list, number, i), do: list |> List.delete(number * i) |> remove_multiples(number, i+1)

end
