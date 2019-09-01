defmodule Markdown do

  import String, only: [ split: 2, split: 3, replace: 3 ]
  import Enum, only: [ map_join: 2 ]

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t) :: String.t
  def parse(markdown), do: markdown |> split("\n") |> map_join(&process_line/1) |> inner_tags

  defp process_line("#" <> _ = line), do: header(line)
  defp process_line("* " <> line), do: line |> wrap_with_tag("li")
  defp process_line(line), do: line |> wrap_with_tag("p")

  defp inner_tags text do
    text
      |> replace(~r/__(.+)__/U, "<strong>\\1</strong>")
      |> replace(~r/_(.+)_/U, "<em>\\1</em>")
      |> replace(~r/(<li>.+<\/li>)/, "<ul>\\1</ul>")
  end

  defp header line do
    [ level, text ] = split line, " ", parts: 2
    text |> wrap_with_tag("h#{ String.length level }")
  end

  defp wrap_with_tag(text, tag), do: "<#{ tag }>#{ text }</#{ tag }>"

end
