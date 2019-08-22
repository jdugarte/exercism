defmodule BinTree do

  import Inspect.Algebra

  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{ value: any, left: BinTree.t | nil, right: BinTree.t | nil }
  defstruct value: nil, left: nil, right: nil

  # A custom inspect instance purely for the tests, this makes error messages
  # much more readable.
  #
  # BT[value: 3, left: BT[value: 5, right: BT[value: 6]]] becomes (3:(5::(6::)):)
  def inspect(%BinTree{value: v, left: l, right: r}, opts) do
    concat ["(", to_doc(v, opts),
            ":", (if l, do: to_doc(l, opts), else: ""),
            ":", (if r, do: to_doc(r, opts), else: ""),
            ")"]
  end

end

defmodule Zipper do

  @type t :: { BinTree.t, next :: BinTree.t | :root }

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t) :: Zipper.t
  def from_tree(bt), do: { bt, :root }

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t) :: BinTree.t
  def to_tree({ bt, :root }), do: bt
  def to_tree(zipper), do: zipper |> up |> to_tree

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t) :: any
  def value({ bt, _ }), do: bt.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t) :: Zipper.t | nil
  def left({ %BinTree{ left: left }, _ }) when left == nil, do: nil
  def left({ bt, next }), do: { bt.left, { :left, bt, next } }

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t) :: Zipper.t | nil
  def right({ %BinTree{ right: right }, _ }) when right == nil, do: nil
  def right({ bt, next }), do: { bt.right, { :right, bt, next } }

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t) :: Zipper.t
  def up({ _, :root }), do: nil
  def up({ _, { _, parent, next }}), do: { parent, next }

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t, any) :: Zipper.t
  def set_value(z, v) do
    update z, v, :value
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t, BinTree.t) :: Zipper.t
  def set_left(z, l) do
    update z, l, :left
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t, BinTree.t) :: Zipper.t
  def set_right(z, r) do
    update z, r, :right
  end

  @spec update(Zipper.t, any, { :left | :right | :value }) :: Zipper.t
  defp update({ focus, :root }, value, property) do
    { focus |> Map.put(property, value), :root }
  end
  defp update({ focus, { direction, parent, next } }, value, property) do
    focus = focus |> Map.put(property, value)
    { _, parent } = parent |> Map.get_and_update(direction, fn focus_in_parent -> { focus_in_parent, focus } end)
    IO.inspect parent
    { focus, { direction, parent, next } }
  end

end
