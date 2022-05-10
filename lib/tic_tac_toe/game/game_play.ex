defmodule TicTacToe.Game.GamePlay do
  defstruct [:player1, :player2, scores: %{player1: [], player2: []}]

  alias TicTacToe.Game.Player

  def new_game(player1, player2) do
    %__MODULE__{player1: player1, player2: player2}
  end

  def play(game, player, position) do
    player
    |> Player.update_player_score(position)
    |> update_score(game)
  end

  defp update_score(player, game) do
    if game.player1.key == player.key do
      %{game | player1: player}
    else
      %{game | player2: player}
    end
  end
end
