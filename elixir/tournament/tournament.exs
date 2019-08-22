defmodule Tournament do

  import String, only: [ split: 2, pad_trailing: 2, pad_leading: 2 ]
  import Enum, only: [ filter: 2, reduce: 3, map: 2, join: 2, reverse: 1 ]

  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally input do
    input |> filter(&valid?/1) |> reduce(%{}, &parse/2) |> sort |> format
  end

  defp valid? line do
    case split line, ";" do
      [ _, _, result ] when result in ~w[ win loss draw ] -> true
      _ -> false
    end
  end

  defp parse line, results do
    [ name_a, name_b, result ] = split line, ";"
    [ result_a, result_b ] = calculate result
    results
      |> Map.update(name_a, result_a, &(merge &1, result_a))
      |> Map.update(name_b, result_b, &(merge &1, result_b))
  end

  defp merge current, new do
    Map.merge current, new, fn _, current, new -> current + new end
  end

  defp calculate result do
    case result do
      "win"  -> [ %{ mp: 1, w: 1, d: 0, l: 0, p: 3 }, %{ mp: 1, w: 0, d: 0, l: 1, p: 0 } ]
      "draw" -> [ %{ mp: 1, w: 0, d: 1, l: 0, p: 1 }, %{ mp: 1, w: 0, d: 1, l: 0, p: 1 } ]
      "loss" -> calculate("win") |> reverse
    end
  end

  defp sort results do
    Enum.sort results, fn { name_a, result_a }, { name_b, result_b } ->
      result_a[:p] >= result_b[:p] and name_a < name_b
    end
  end

  @header { "Team", %{ mp: "MP", w: "W", d: "D", l: "L", p: "P" } }

  defp format results do
    [ @header | results ] |> map(&format_line/1) |> join("\n")
  end

  defp format_line { name, results } do
    "#{ pad_trailing name, 30 } | " <>
    "#{ pad_leading "#{results[:mp]}", 2 } | " <>
    "#{ pad_leading "#{results[:w]}",  2 } | " <>
    "#{ pad_leading "#{results[:d]}",  2 } | " <>
    "#{ pad_leading "#{results[:l]}",  2 } | " <>
    "#{ pad_leading "#{results[:p]}",  2 }"
  end

end
