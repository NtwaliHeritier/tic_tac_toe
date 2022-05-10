defmodule TicTacToe.Game.Player do
  defstruct [:name, :key, score_combo: []]

  def new(name, key) do
    %__MODULE__{name: name, key: key}
  end

  def update_player_score(player, score_combo) do
    Map.update(player, :score_combo, [], &[score_combo | &1])
  end
end
