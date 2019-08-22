defmodule Garden do

  import String, only: [ split: 2, graphemes: 1 ]
  import Enum, only: [ sort: 1, zip: 2, map: 2, concat: 2, into: 2, join: 1, reverse: 1, chunk_every: 2 ]

  @doc """
    Accepts a string representing the arrangement of cups on a windowsill and a
    list with names of students in the class. The student names list does not
    have to be in alphabetical order.

    It decodes that string into the various gardens for each student and returns
    that information in a map.
  """

  @students ~w[ alice bob charlie david eve fred ginny harriet ileana joseph kincaid larry ]a
  @seeds %{ "G" => :grass, "C" => :clover, "R" => :radishes, "V" => :violets }

  @spec info(String.t(), list) :: map
  def info info_string, student_names \\ @students do
    student_names
      |> sort |> zip(parse_garden(info_string))
      |> map(&parse_seeds/1)
      |> concat(student_names |> map(&{ &1, {} }))
      |> reverse
      |> into(Map.new)
  end

  defp parse_garden info_string do
    [ row1, row2 ] = info_string |> split("\n") |> map(fn row ->
      row |> graphemes |> chunk_every(2) |> map(&join/1)
    end)
    row1 |> zip(row2) |> map(&(elem(&1, 0) <> elem(&1, 1)))
  end

  defp parse_seeds { name, seeds } do
    { name, seeds |> graphemes |> map(&(@seeds[&1])) |> List.to_tuple }
  end

end
