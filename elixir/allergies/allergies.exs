defmodule Allergies do

  use Bitwise

  @allergies ~w{ eggs peanuts shellfish strawberries tomatoes chocolate pollen cats }

  @doc """
  List the allergies for which the corresponding flag bit is true.
  """
  @spec list(non_neg_integer) :: [String.t]
  def list(flags) do
    for { allergen, i } <- Enum.with_index(@allergies), (flags &&& trunc(:math.pow(2, i))) != 0, do: allergen
  end

  @doc """
  Returns whether the corresponding flag bit in 'flags' is set for the item.
  """
  @spec allergic_to?(non_neg_integer, String.t) :: boolean
  def allergic_to?(flags, item), do: item in list(flags)

end
