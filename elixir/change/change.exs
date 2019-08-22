defmodule Change do

  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t}
  def generate(_, target) when target < 0, do: { :error, "cannot change" }
  def generate(coins, target) do
    options = coins
              |> Enum.with_index
              |> Enum.map(fn { _, index } -> coins |> List.delete_at(index) |> Enum.reverse |> get_change(target) end)
              |> Enum.filter(&(Enum.sum(&1) == target))
    if Enum.empty?(options) do
      { :error, "cannot change" }
    else
      { :ok, options |> Enum.min_by(&length/1) |> Enum.reverse }
    end
  end

  defp get_change([], _), do: []
  defp get_change([ coin | coins ], amount) when coin > amount, do: get_change(coins, amount)
  defp get_change([ coin | coins ], amount) when coin == amount, do: [ coin | get_change(coins, amount-coin) ]
  defp get_change(all = [ coin | coins ], amount) do
    if amount > coin and !Enum.empty?(coins) and List.last(coins) > amount-coin do
      get_change(coins, amount)
    else
      [ coin | get_change(all, amount-coin) ]
    end
  end

end
