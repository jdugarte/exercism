defmodule Words do

  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t) :: map
  def count sentence do
    groups = sentence
             |> String.downcase
             |> String.split(~r/[^\pL-\d]+/u, trim: true)
             |> Enum.group_by(& &1)
    for { word, words } <- groups, into: %{}, do: { word, length(words) }
  end

end
