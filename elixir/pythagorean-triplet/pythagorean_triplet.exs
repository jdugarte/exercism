defmodule Triplet do

  @doc """
  Calculates sum of a given triplet of integers.
  """
  @spec sum([non_neg_integer]) :: non_neg_integer
  def sum(triplet), do: Enum.sum triplet

  @doc """
  Calculates product of a given triplet of integers.
  """
  @spec product([non_neg_integer]) :: non_neg_integer
  def product(triplet), do: Enum.reduce triplet, &*/2

  @doc """
  Determines if a given triplet is pythagorean. That is, do the squares of a and b add up to the square of c?
  """
  @spec pythagorean?([non_neg_integer]) :: boolean
  def pythagorean?([a, b, c]), do: :math.pow(a, 2) + :math.pow(b, 2) == :math.pow(c, 2)

  @doc """
  Generates a list of pythagorean triplets from a given min (or 1 if no min) to a given max.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max) do
    for i <- min..max, j <- i..max, k <- j..max, pythagorean?([ i, j, k ]), do: [ i, j, k ]
  end

  @doc """
  Generates a list of pythagorean triplets from a given min to a given max, whose values add up to a given sum.
  """
  @spec generate(non_neg_integer, non_neg_integer, non_neg_integer) :: [list(non_neg_integer)]
  def generate(min, max, sum) do
    for i <- min..max, j <- i..max, k <- j..max, pythagorean?([ i, j, k ]), sum([ i, j, k ]) == sum, do: [ i, j, k ]
  end

end
