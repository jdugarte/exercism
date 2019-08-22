defmodule Meetup do

  import Date, only: [ new: 3, days_in_month: 1, range: 2, day_of_week: 1 ]
  import Enum, only: [ find_index: 2, find: 2, reverse: 1 ]

  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
      :monday | :tuesday | :wednesday
    | :thursday | :friday | :saturday | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @days ~w[ monday tuesday wednesday thursday friday saturday sunday ]a
  @start_day %{ first: 1, second: 8, third: 15, fourth: 22, teenth: 13 }

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: :calendar.date
  def meetup year, month, weekday, schedule do
    in_range = date_range year, month, schedule
    day_week = find_index(@days, &(&1 == weekday)) + 1
    date     = find in_range, &(day_of_week(&1) == day_week)
    { year, month, date.day }
  end

  defp date_range(year, month, :last), do: date_range(year, month, :first) |> reverse
  defp date_range(year, month, schedule) do
    { :ok, first } = new year, month, @start_day[schedule]
    { :ok, last  } = new year, month, days_in_month(first)
    range first, last
  end

end
