defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" -> "Fine. Be that way!"
      String.ends_with?(input, "?") -> "Sure."
      input =~ ~r/[\p{Lu}\p{Lt}](1|!)*$/u -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
