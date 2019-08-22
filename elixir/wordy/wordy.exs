defmodule Wordy do

  @operators %{
    "plus"          => &Kernel.+/2,
    "minus"         => &Kernel.-/2,
    "multiplied by" => &Kernel.*/2,
    "divided by"    => &Kernel.div/2,
  }
  @matching_operators @operators |> Map.keys |> Enum.join("|") |> String.replace(" ", "\\s")

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t) :: integer
  def answer(question), do: question |> String.slice(8..-1) |> calculate

  defp calculate question do
    case parse(question) do
      [ left, operator, right, rest ] -> calculate "#{ perform operator, left, right }#{ rest }"
      result                          -> String.to_integer result
    end
  end

  defp parse question do
    case Regex.run(parser(), question) do
      nil -> raise ArgumentError
      [ _, _, _, _, _, _, number ] -> number
      parts -> Enum.slice parts, 2..-1
    end
  end

  defp perform operator, left, right do
    apply @operators[operator], [ String.to_integer(left), String.to_integer(right) ]
  end

  defp parser do
    ~r/
        (
          (-?\d+) # number
          \s+     # space
          (#{@matching_operators}) # operation
          \s+     # space
          (-?\d+) # number
          (.+)$   # rest of the statement
        )
      |           # OR
        (-?\d+)   # number
        \?        # question mark
      /x
  end

end
