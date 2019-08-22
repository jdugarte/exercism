defmodule Isogram do

  @doc """
  Determines if a word or sentence is an isogram
  """
  @spec isogram?(String.t) :: boolean
  def isogram?(sentence) do
    isogram = Regex.scan ~r/\w/, String.downcase(sentence)
    isogram |> Enum.uniq |> length == isogram |> length
  end

end
