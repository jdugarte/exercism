defmodule RailFenceCipher do

  import Enum, only: [ join: 1, chunk_every: 2, map: 2, at: 2, take_every: 2, map_join: 2, to_list: 1, find_index: 2 ]
  import String, only: [ slice: 2, graphemes: 1 ]
  import List, only: [ flatten: 1, duplicate: 2, replace_at: 3, zip: 1 ]

  @doc """
  Encode a given plaintext to the corresponding rail fence ciphertext
  """
  @spec encode(String.t, pos_integer) :: String.t
  def encode("", _), do: ""
  def encode(str, 1), do: str
  def encode(str, rails), do: for line <- 1..rails, into: "", do: rail_line(str, rails, line)

  defp rail_line(str, rails, 1), do: str |> border(rails)
  defp rail_line(str, rails, line) when line == rails, do: str |> slice(rails-1..-1) |> border(rails)
  defp rail_line(str, rails, line) do
    str |> slice(line-1..-1) |> graphemes
        |> chunk_every(chunk(rails)) |> map(&[ hd(&1), at(&1, chunk(rails)-(line-1)*2) ])
        |> flatten |> join
  end

  defp border(str, rails), do: str |> graphemes |> take_every(chunk(rails)) |> join

  defp chunk(rails), do: rails * 2 - 2

  @doc """
  Decode a given rail fence ciphertext to the corresponding plaintext
  """
  @spec decode(String.t, pos_integer) :: String.t
  def decode("", _), do: ""
  def decode(str, 1), do: str
  def decode(str, rails) do
    create_fence(str, rails)
      |> transpose |> flatten |> fill_fence(str)
      |> chunk_every(String.length(str)) |> transpose |> map_join(&join/1)
  end

  defp create_fence(str, rails) do
    position = zig_zag(rails)
    for n <- 0..String.length(str)-1, do: nil |> duplicate(rails) |> replace_at(at(position, n), "?")
  end

  defp zig_zag(rails), do: to_list(0..rails-1) ++ to_list(rails-2..1) |> Stream.cycle

  defp fill_fence(fence, ""), do: fence
  defp fill_fence(fence, <<char::binary-1, tail::binary>>) do
    index = fence |> find_index(&(&1 == "?"))
    fence |> replace_at(index, char) |> fill_fence(tail)
  end

  defp transpose(matrix), do: matrix |> zip |> map(&Tuple.to_list/1)

end
