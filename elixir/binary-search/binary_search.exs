defmodule BinarySearch do

  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _), do: :not_found
  def search(numbers, key), do:  check_in_range numbers, key, 0..tuple_size(numbers)-1

  defp check_in_range(numbers, key, range = min..max) do
    index = div max+min, 2
    is_it? index, numbers, key, range
  end

  defp is_it?(index, numbers, key, _) when key == elem(numbers, index), do: { :ok, index }
  defp is_it?(index, numbers, key, index..index) when key != elem(numbers, index), do: :not_found

  defp is_it?(index, numbers, key, _..max) when key > elem(numbers, index) do
    check_in_range numbers, key, index+1..max
  end
  defp is_it?(index, numbers, key, min.._) when key < elem(numbers, index) do
    check_in_range numbers, key, min..index-1
  end

end
