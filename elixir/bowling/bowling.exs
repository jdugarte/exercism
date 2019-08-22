defmodule Bowling do

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start, do: []

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t
  def roll(_, roll) when roll < 0, do: { :error, "Negative roll is invalid" }
  def roll(_, roll) when roll > 10, do: exceeded_pins()
  def roll([ [ previous ] | _ ], roll) when previous < 10 and previous + roll > 10, do: exceeded_pins()
  def roll(game = [ [ last | last2 ] | _ ], _) when length(game) >= 10 and last != 10 and last + hd(last2) != 10 do
    { :error, "Cannot roll after game is over" }
  end
  def roll([ [ previous ] | game ], roll) when previous < 10, do: [ [ previous, roll ] | game ]
  def roll(game, roll), do: [ [ roll ] | game ]

  defp exceeded_pins, do: { :error, "Pin count exceeds pins on the lane" }

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t
  def score(game) when length(game) < 10, do: unfinished_game()
  def score(game = [ [10] | _ ]) when length(game) == 10, do: unfinished_game()
  def score(game = [ [10] | [ [10] | _ ] ]) when length(game) == 11, do: unfinished_game()
  def score(game = [ [ first, second ] | _ ]) when length(game) == 10 and first + second == 10, do: unfinished_game()
  def score(game), do: game |> Enum.reverse |> points_per_frame |> Enum.sum

  defp unfinished_game, do: { :error, "Score cannot be taken until the end of the game" }

  defp points_per_frame(game, n \\ 1)
  defp points_per_frame(_, 11), do: []
  defp points_per_frame([ frame | tail ], n), do: [ points_in(frame, tail) | points_per_frame(tail, n+1) ]

  defp points_in([ 10 ], tail), do: 10 + next_2_rolls(tail)
  defp points_in([ first, second ], tail) when first + second == 10, do: 10 + next_roll(tail)
  defp points_in([ first, second ], _), do: first + second

  defp next_roll(game), do: game |> List.flatten |> hd
  defp next_2_rolls(game), do: game |> List.flatten |> Enum.take(2) |> Enum.sum

end
