defmodule SecretHandshake do

  use Bitwise

  @actions %{ 0b1 => "wink", 0b10 => "double blink", 0b100 => "close your eyes", 0b1000 => "jump" }
  @reverse 0b10000

  defmacro has_bit?(code, bit) do
    quote do
      (unquote(code) &&& unquote(bit)) != 0
    end
  end

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    actions(code) |> maybe_reverse(code)
  end

  defp actions(code) do
    for { bit, action } <- @actions, has_bit?(code, bit), do: action
  end

  defp maybe_reverse(actions, code) when has_bit?(code, @reverse), do: Enum.reverse actions
  defp maybe_reverse(actions, _), do: actions

end

