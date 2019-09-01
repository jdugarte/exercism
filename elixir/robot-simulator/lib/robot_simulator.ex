defmodule RobotSimulator do

  @cardinal_directions ~w[ north east south west ]a

  defguard is_position(x, y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _) when direction not in @cardinal_directions,
    do: { :error, "invalid direction" }
  def create(direction, position = {x, y}) when is_position(x,y),
    do: %{ direction: direction, position: position }
  def create(_, _),
    do: { :error, "invalid position" }

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, ""), do: robot
  def simulate(robot, <<next::binary-1, tail::binary>>) when next in ~w[ L R A ] do
    simulate(if(next == "A", do: advance(robot), else: change_direction(robot, next)), tail)
  end
  def simulate(_, _), do: { :error, "invalid instruction" }

  @right @cardinal_directions |> List.duplicate(2) |> List.flatten
  @left Enum.reverse(@right)
  @directions %{ "L" => @left, "R" => @right }

  defp change_direction(robot, instruction) do
    %{ robot | direction: new_direction(robot, instruction) }
  end

  defp new_direction(%{ direction: direction }, instruction) do
    next_direction = Enum.find_index(@directions[instruction], &(&1 == direction)) + 1
    Enum.at(@directions[instruction], next_direction)
  end

  defp advance(robot) do
    %{ robot | position: new_position(robot) }
  end

  defp new_position(%{ direction: direction, position: { x, y }}) do
    case direction do
      :north -> { x, y + 1 }
      :south -> { x, y - 1 }
      :east  -> { x + 1, y }
      :west  -> { x - 1, y }
    end
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{ direction: direction }), do: direction

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{ position: position }), do: position

end
