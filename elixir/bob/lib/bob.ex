defmodule Bob do
  def hey(input) do
    cond do
      String.trim(input) == "" -> "Fine. Be that way!"
      input =~ ~r/[\p{Lu}\p{Lt}]\?+$/u -> "Calm down, I know what I'm doing!"
      String.ends_with?(input, "?") -> "Sure."
      input =~ ~r/[\p{Lu}\p{Lt}](1|!)*$/u -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end
