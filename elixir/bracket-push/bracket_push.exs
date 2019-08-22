defmodule BracketPush do

  import String, only: [ graphemes: 1 ]
  import Enum, only: [ reduce: 3, find_index: 2, at: 2, empty?: 1 ]

  @open  ~w" [ { ( "
  @close ~w" ] } ) "
  
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t) :: boolean
  def check_brackets str do
    try do
      str
        |> graphemes
        |> reduce([], fn
                        char, stack when char in @open  -> [ char | stack ]
                        char, stack when char in @close -> check_closing_bracket char, stack
                        _, stack                        -> stack
                      end)
        |> empty?
    catch
      :mismatch -> false
    end
  end

  defp check_closing_bracket char, stack do
    if empty?(stack), do: throw :mismatch
    index = find_index @close, &(&1 == char)
    [ head | tail ] = stack
    if at(@open, index) != head, do: throw :mismatch
    tail
  end

end
