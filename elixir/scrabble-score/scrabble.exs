defmodule Scrabble do

  @points_per_letter %{
    ~w[ A E I O U L N R S T ] => 1,
    ~w[ D G ]                 => 2,
    ~w[ B C M P ]             => 3,
    ~w[ F H V W Y ]           => 4,
    ~w[ K ]                   => 5,
    ~w[ J X ]                 => 8,
    ~w[ Q Z ]                 => 10,
  }

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t) :: non_neg_integer
  def score word do
    word
      |> String.trim
      |> String.upcase
      |> String.graphemes
      |> Enum.reduce(0, fn letter, points -> points + points_per(letter) end)
  end

  defp points_per letter do
    { _, points } = Enum.find @points_per_letter, fn { letters, _ } -> letter in letters end
    points
  end

end
