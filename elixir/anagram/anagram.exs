defmodule Anagram do

  import String, only: [ downcase: 1, graphemes: 1, to_atom: 1 ]
  import Enum, only: [ join: 1, sort: 1 ]

  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t, [String.t]) :: [String.t]
  def match(base, candidates) do
    encoded_words(candidates, base) |> Keyword.get_values(encoded_word(base))
  end

  def encoded_words(words, base) do
    for word <- words, downcase(base) != downcase(word), into: Keyword.new, do: { encoded_word(word), word }
  end

  defp encoded_word(word) do
    word |> downcase |> graphemes |> sort |> join |> to_atom
  end

end
