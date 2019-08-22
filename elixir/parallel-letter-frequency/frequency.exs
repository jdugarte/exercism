defmodule Frequency do

  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t], pos_integer) :: map
  def frequency texts, workers do
    texts
      |> Task.async_stream(&calculate_frequency/1, max_concurrency: workers)
      |> Enum.reduce([], fn { :ok, partial }, total -> total ++ partial end)
      |> merge_results
  end

  defp calculate_frequency text do
    text
      |> String.downcase
      |> String.replace(~r/[^\p{L}]/u, "")
      |> String.graphemes
      |> Enum.group_by(&(&1))
      |> Enum.map(fn { letter, list } -> { letter, length(list) } end)
  end

  defp merge_results results do
    Enum.reduce results, %{}, fn { letter, count }, acc -> Map.update acc, letter, count, &(&1 + count) end
  end

end
