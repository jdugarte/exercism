defmodule PigLatin do

  @vowels ~w[ a e i o u ]
  @vowels_ish ~w[ yt xr ]
  @double_consonants ~w[ ch qu th ]
  @triple_consonants ~w[ thr sch squ ]

  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    phrase
      |> String.split
      |> Enum.map(&translate_word/1)
      |> Enum.map(&("#{&1}ay"))
      |> Enum.join(" ")
  end

  defp translate_word(<<head::binary-3, tail::binary>>) when head in @triple_consonants, do: "#{tail}#{head}"
  defp translate_word(<<head::binary-2, tail::binary>>) when head in @double_consonants, do: "#{tail}#{head}"
  defp translate_word(word = <<head::binary-2, _::binary>>) when head in @vowels_ish, do: word
  defp translate_word(<<head::binary-1, tail::binary>>) when head not in @vowels, do: "#{tail}#{head}"
  defp translate_word(word), do: word

end
