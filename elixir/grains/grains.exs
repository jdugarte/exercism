defmodule Grains do

  @doc """
  Calculate two to the power of the input minus one.
  """
  @spec square(pos_integer) :: pos_integer
  def square(number) when number in 1..64, do: { :ok, pow(number) }
  def square(_), do: { :error, "The requested square must be between 1 and 64 (inclusive)" }

  @doc """
  Adds square of each number from 1 to 64.
  """
  @spec total :: pos_integer
  def total, do: { :ok, Enum.reduce(1..64, 0, &(&2 + pow(&1))) }

  defp pow(number), do: trunc(:math.pow(2, number - 1))

end
