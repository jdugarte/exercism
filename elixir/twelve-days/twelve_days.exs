defmodule TwelveDays do

  @gifts [
    " a Partridge in a Pear Tree.",
    " two Turtle Doves,",
    " three French Hens,",
    " four Calling Birds,",
    " five Gold Rings,",
    " six Geese-a-Laying,",
    " seven Swans-a-Swimming,",
    " eight Maids-a-Milking,",
    " nine Ladies Dancing,",
    " ten Lords-a-Leaping,",
    " eleven Pipers Piping,",
    " twelve Drummers Drumming,",
  ]

  @doc """
  Given a `number`, return the song's verse for that specific day, including
  all gifts for previous days in the same line.
  """
  @spec verse(number :: integer) :: String.t()
  def verse(1), do: "#{ lead(1) }#{ hd(@gifts) }"
  def verse(number) do
    lines = [ " and#{ hd(@gifts) }" | Enum.slice(@gifts, 1..number-1) ] |> Enum.reverse
    for line <- lines, into: lead(number), do: line
  end

  @days ~w[ first second third fourth fifth sixth seventh eighth ninth tenth eleventh twelfth ]
  defp lead(number), do: "On the #{Enum.at(@days, number-1)} day of Christmas my true love gave to me,"

  @doc """
  Given a `starting_verse` and an `ending_verse`, return the verses for each
  included day, one per line.
  """
  @spec verses(starting_verse :: integer, ending_verse :: integer) :: String.t()
  def verses(starting_verse, ending_verse) do
    starting_verse..ending_verse
      |> Enum.to_list
      |> Enum.map_join("\n", &verse/1)
  end

  @doc """
  Sing all 12 verses, in order, one verse per line.
  """
  @spec sing():: String.t()
  def sing do
    verses 1, 12
  end

end
