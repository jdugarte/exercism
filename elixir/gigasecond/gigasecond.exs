defmodule Gigasecond do

  @doc """
  Calculate a date one billion seconds after an input date.
  """
  @spec from({{pos_integer, pos_integer, pos_integer}, {pos_integer, pos_integer, pos_integer}}) :: :calendar.datetime

  @gigaseconds trunc :math.pow(10, 9)

  def from erl_date_time do
    with { :ok, naive_date_time } <- NaiveDateTime.from_erl erl_date_time do
      naive_date_time
      |> NaiveDateTime.add(@gigaseconds)
      |> NaiveDateTime.to_erl
    end
  end

end
