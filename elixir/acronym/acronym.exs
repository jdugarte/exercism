defmodule Acronym do

  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    Regex.scan(~r/(^\w|(?<=\s)\w|(?<=\S)[\p{Lu}\p{Lt}])/u, string)
      |> Enum.map_join(&hd/1)
      |> String.upcase
  end

end
