defmodule BeerSong do

  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t
  def verse(number) do
    """
    #{ String.capitalize bottles(number) } of beer on the wall, #{ bottles number } of beer.
    #{ take_or_buy number }, #{ bottles number-1 } of beer on the wall.
    """
  end

  defp bottles(0), do: "no more bottles"
  defp bottles(1), do: "1 bottle"
  defp bottles(-1), do: bottles 99
  defp bottles(count), do: "#{count} bottles"

  defp take_or_buy(0), do: "Go to the store and buy some more"
  defp take_or_buy(1), do: "Take it down and pass it around"
  defp take_or_buy(_), do: "Take one down and pass it around"

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t) :: String.t
  def lyrics(range \\ 99..0), do: Enum.map_join range, "\n", &verse/1

end
