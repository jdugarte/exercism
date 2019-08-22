defmodule Atbash do

  import String, only: [ downcase: 1, replace: 3, graphemes: 1 ]
  import Enum, only: [ map: 2, chunk_every: 2, map_join: 2, map_join: 3, join: 1, to_list: 1, reverse: 1, zip: 2 ]

  @doc """
  Encode a given plaintext to the corresponding ciphertext

  ## Examples

  iex> Atbash.encode("completely insecure")
  "xlnko vgvob rmhvx fiv"
  """
  @spec encode(String.t) :: String.t
  def encode plaintext do
    cipher = create_cipher_for ?a..?z
    plaintext |> to_graphemes |> map(&(cipher[&1] || &1)) |> chunk_every(5) |> map_join(" ", &join/1)
  end

  @spec decode(String.t) :: String.t
  def decode cipher do
    decipher = create_cipher_for ?z..?a
    cipher |> to_graphemes |> map_join(&(decipher[&1] || &1))
  end

  defp create_cipher_for base do
    original = base |> to_list |> to_string |> graphemes
    shifted  = original |> reverse
    original |> zip(shifted) |> Map.new
  end

  defp to_graphemes string do
    string |> replace(~r/[^\w]/, "") |> downcase |> graphemes
  end

end
