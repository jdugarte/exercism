defmodule Bob do

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      String.trim(input) == "" ->
        "Fine. Be that way!"

      upcase?(input) ->
        if String.ends_with?(input, "?") do
          "Calm down, I know what I'm doing!"
        else
          "Whoa, chill out!"
        end

      String.ends_with?(input, "?") ->
        "Sure."

      true ->
        "Whatever."
    end
  end

  defp upcase?(string) do
    string == String.upcase(string) && string != String.downcase(string)
  end

end
