defmodule Diamond do

  import String, only: [ duplicate: 2, reverse: 1, slice: 2 ]

  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t
  def build_shape(letter) do
    len  = letter - ?A + 1
    half = for n <- 0..len-1 do
      half = duplicate(" ", len-n-1) <> <<?A + n>> <> duplicate(" ", n)
      mirror = half |> reverse |> slice(1..-1)
      half <> mirror <> "\n"
    end
    mirror = half |> Enum.reverse |> Enum.slice(1..-1)
    Enum.join half ++ mirror
  end

end
