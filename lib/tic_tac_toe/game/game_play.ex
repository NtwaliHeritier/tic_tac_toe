defmodule TicTacToe.Game.GamePlay do
  defstruct [:player1, :player2, :winner, :player_turn]

  alias TicTacToe.Game.{Player, WinningChecker}

  def new_game(player1, player2) do
    %__MODULE__{player1: player1, player2: player2}
  end

  def play(game, player, position) do
    player
    |> check_player(game)
    |> update_game_score(position)
    |> WinningChecker.check()
  end

  defp check_player(player, game) do
    if game.player1.key == player.key do
      %{game | player_turn: :player1}
    else
      %{game | player_turn: :player1}
    end
  end

  defp update_game_score(game, position) do
    if game.player_turn == :player1 do
      %{game | player1: Player.update_player_score(game.player1, position)}
    else
      %{game | player2: Player.update_player_score(game.player2, position)}
    end
  end
end
