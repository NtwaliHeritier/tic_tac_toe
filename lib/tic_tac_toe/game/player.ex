defmodule TicTacToe.Game.Player do
  defstruct [:name, :key, score_combo: []]

  def new(name, key) do
    %__MODULE__{name: name, key: key}
  end
end
