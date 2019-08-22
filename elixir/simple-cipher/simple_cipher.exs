defmodule SimpleCipher do

  import String, only: [ slice: 2 ]
  import Enum, only: [ map: 2, zip: 2 ]

  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    shift_keys  = key |> slice(0..String.length(plaintext)-1) |> to_charlist |> map(&(&1 - 97)) |> Stream.cycle
    shift_pairs = plaintext |> to_charlist |> zip(shift_keys)
    for { char, shift } <- shift_pairs, into: "", do: <<shift_integer_by(char, shift)>>
  end

  defp shift_integer_by(int_char, shift) when int_char in ?a..?z, do: ?a + rem((int_char + shift - ?a), 26)
  defp shift_integer_by(int_char, _), do: int_char

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    shift_keys  = key |> slice(0..String.length(ciphertext)-1) |> to_charlist |> map(&(&1 - 97)) |> Stream.cycle
    shift_pairs = ciphertext |> to_charlist |> zip(shift_keys)
    for { char, shift } <- shift_pairs, into: "", do: <<unshift_integer_by(char, shift)>>
  end

  defp unshift_integer_by(int_char, shift) when int_char in ?a..?z, do: ?z - rem((?z - int_char + shift), 26)
  defp unshift_integer_by(int_char, _), do: int_char

end
