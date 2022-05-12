defmodule TicTacToe.Game.Player do
  defstruct [:name, :key, score_combo: []]

  def new(name) do
    %__MODULE__{name: name}
  end

  def assign_key(player, key) do
    %{player | key: key}
  end

  def update_player_score(player, score_combo) do
    Map.update(player, :score_combo, [], &[score_combo | &1])
  end
end
