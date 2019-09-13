defmodule Bowling do

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @tenpin 10
  @total_frames 10
  defguard unfinished?(game) when length(game) < @total_frames
  defguard last_frame?(game) when length(game) == @total_frames
  defguard extra_frame?(game) when length(game) == @total_frames + 1

  defguard roll_after_game_over?(game, last_roll, previous_rolls)
    when length(game) >= @total_frames
     and last_roll != @tenpin
     and last_roll + hd(previous_rolls) != @tenpin

  defguard exceeding_rolls?(previous_roll, current_roll)
    when previous_roll < @tenpin
     and previous_roll + current_roll > @tenpin

  @spec start() :: any
  def start, do: []

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """
  @spec roll(any, integer) :: any | String.t
  def roll(_, roll)
    when roll < 0,
    do: { :error, "Negative roll is invalid" }

  def roll(_, roll)
    when roll > @tenpin,
    do: exceeded_pins()

  def roll([ [ previous_roll ] | _ ], current_roll)
    when exceeding_rolls?(previous_roll, current_roll),
    do: exceeded_pins()

  def roll(game = [ [ last_roll | previous_rolls ] | _ ], _)
    when roll_after_game_over?(game, last_roll, previous_rolls),
    do: { :error, "Cannot roll after game is over" }

  def roll([ [ previous_roll ] | game ], current_roll)
    when previous_roll < @tenpin,
    do: [ [ previous_roll, current_roll ] | game ]

  def roll(game, roll),
    do: [ [ roll ] | game ]

  defp exceeded_pins, do: { :error, "Pin count exceeds pins on the lane" }

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """
  @spec score(any) :: integer | String.t
  def score(game)
    when unfinished?(game),
    do: unfinished_game_error()

  def score(game = [ [ @tenpin ] | _ ])
    when last_frame?(game),
    do: unfinished_game_error()

  def score(game = [ [ @tenpin ] | [ [ @tenpin ] | _ ] ])
    when extra_frame?(game),
    do: unfinished_game_error()

  def score(game = [ [ first_roll, second_roll ] | _ ])
    when last_frame?(game) and first_roll + second_roll == @tenpin,
    do: unfinished_game_error()

  def score(game),
    do: game |> Enum.reverse |> points_per_frame |> Enum.sum

  defp unfinished_game_error, do: { :error, "Score cannot be taken until the end of the game" }

  defp points_per_frame(game, n \\ 1)
  defp points_per_frame(_, 11), do: []
  defp points_per_frame([ frame | tail ], n),
    do: [ points_in(frame, tail) | points_per_frame(tail, n+1) ]

  defp points_in([ @tenpin ], tail),
    do: @tenpin + next_2_rolls(tail)

  defp points_in([ first_roll, second_roll ], tail)
    when first_roll + second_roll == @tenpin,
    do: @tenpin + next_roll(tail)

  defp points_in([ first_roll, second_roll ], _),
    do: first_roll + second_roll

  defp next_roll(game), do: game |> List.flatten |> hd
  defp next_2_rolls(game), do: game |> List.flatten |> Enum.take(2) |> Enum.sum

end
