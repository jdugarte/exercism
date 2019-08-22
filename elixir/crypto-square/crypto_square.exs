defmodule CryptoSquare do

  @doc """
  Encode string square methods
  ## Examples

    iex> CryptoSquare.encode("abcd")
    "ac bd"
  """
  @spec encode(String.t) :: String.t
  def encode(str) when str == "", do: ""
  def encode(str) do
    normalized = str |> String.replace(~r/[^\w]/, "") |> String.downcase
    cols = normalized |> String.length |> :math.sqrt |> Float.ceil |> trunc
    normalized
      |> String.graphemes
      |> Enum.chunk_every(cols, cols, List.duplicate(" ", cols))
      |> List.zip
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&Enum.join/1)
      |> Enum.map(&String.trim/1)
      |> Enum.join(" ")
  end

end
